# pid_fedAvg.py
# PID-based FedAvg strategy with validation-loss-based pruning (PyTorch required).
# Usage (example):
# strategy = PIDFedAvg(
#     model_fn=my_model_fn,
#     val_loader=server_val_loader,
#     device="cpu",
#     criterion=torch.nn.CrossEntropyLoss(),
#     k=2.0, ki=0.1, kd=1.0,
#     mad_multiplier=2.0, prune_percentile=90.0, start_pruning_round=3,
#     min_clients_to_prune=3
# )

from typing import List, Tuple, Optional, Dict, Any, Callable
import numpy as np
from flwr.server.strategy import FedAvg
from flwr.common import parameters_to_ndarrays, ndarrays_to_parameters, Parameters
import torch


# ---------------- Helper: geometric median (kept if you want it later) ----------------
def geometric_median(points: np.ndarray, eps: float = 1e-5) -> np.ndarray:
    y = np.mean(points, axis=0)
    while True:
        D = np.linalg.norm(points - y, axis=1)
        nonzero = D != 0
        if not np.any(nonzero):
            return y
        Dinv = 1 / D[nonzero]
        W = Dinv / Dinv.sum()
        T = np.sum(points[nonzero] * W[:, np.newaxis], axis=0)
        num_zeros = len(points) - np.sum(nonzero)
        if num_zeros == 0:
            y1 = T
        elif num_zeros == len(points):
            return y
        else:
            R = (T - y) * num_zeros / np.sum(nonzero)
            y1 = T + R
        if np.linalg.norm(y - y1) < eps:
            return y1
        y = y1


# ---------------- Main Strategy ----------------
class PIDFedAvg(FedAvg):
    """
    FedAvg strategy with server-side validation-loss-based pruning + PID smoothing.

    Required server args:
      - model_fn: callable -> returns a fresh PyTorch model (same architecture as clients).
      - val_loader: PyTorch DataLoader with clean validation set on server.
      - device: "cpu" or "cuda" string.
      - criterion: PyTorch loss (e.g., nn.CrossEntropyLoss()).

    Tuning knobs:
      - k, ki, kd: PID gains
      - mad_multiplier / prune_percentile: robust cutoff
      - start_pruning_round: warmup rounds
      - alpha_cos: weight for cosine-similarity term (combine with val loss)
    """

    def __init__(
        self,
        model_fn: Callable[[], torch.nn.Module],
        val_loader,
        device: str,
        criterion,
        k: float = 2.0,
        ki: float = 0.1,
        kd: float = 1.0,
        mad_multiplier: float = 2.0,
        prune_percentile: float = 90.0,
        min_clients_to_prune: int = 3,
        start_pruning_round: int = 3,
        alpha_cos: float = 1.0,
        **kwargs,
    ):
        super().__init__(**kwargs)
        # Server evaluation objects
        self.model_fn = model_fn
        self.val_loader = val_loader
        self.device = device
        self.criterion = criterion

        # PID & pruning params
        self.k, self.ki, self.kd = float(k), float(ki), float(kd)
        self.mad_multiplier = float(mad_multiplier)
        self.prune_percentile = float(prune_percentile)
        self.min_clients_to_prune = int(min_clients_to_prune)
        self.start_pruning_round = int(start_pruning_round)
        self.alpha_cos = float(alpha_cos)

        # PID per-client
        self.client_pid_state: Dict[str, Dict[str, float]] = {}

        # last global ndarrays
        self.global_ndarrays: Optional[List[np.ndarray]] = None

    # ---------- ndarray helpers ----------
    def _flatten_ndarrays(self, nds: List[np.ndarray]) -> np.ndarray:
        return np.concatenate([n.ravel() for n in nds]).astype(np.float32)

    def _unpack_agg_result(self, result):
        """Unpack super().aggregate_fit result (compat with multiple Flower versions)."""
        if result is None:
            return None, {}
        if isinstance(result, tuple):
            return result[0], result[1]
        return result, {}

    # ---------- model <-> ndarrays helpers ----------
    def _set_model_params_from_ndarrays(self, model: torch.nn.Module, nds: List[np.ndarray]):
        """Set model parameters from ndarrays (assumes same ordering)."""
        with torch.no_grad():
            flat_idx = 0
            # Convert each ndarray to torch tensor and assign to parameters in order.
            for p in model.parameters():
                numel = p.numel()
                arr = nds[flat_idx] if flat_idx < len(nds) else None
                # If nds provides full shapes per-parameter (common), use arr directly:
                # Many Flower returns nds as list with same shapes as model.state_dict tensors.
                # We try to match by shape first:
                if arr is not None and arr.size == numel:
                    tensor = torch.from_numpy(arr.reshape(p.shape)).to(p.device)
                    p.data.copy_(tensor)
                    flat_idx += 1
                else:
                    # Fallback: we attempt to reconstruct from a concatenated flat vector
                    raise RuntimeError("Mismatch between server ndarrays and model.parameters shapes. "
                                       "Ensure model architecture matches client models and Flower parameters format.")

    def _evaluate_ndarrays_on_validation(self, nds: List[np.ndarray]) -> Tuple[float, float]:
        """Load ndarrays into a fresh model and compute loss and accuracy on val_loader."""
        model = self.model_fn().to(self.device)
        model.eval()
        try:
            self._set_model_params_from_ndarrays(model, nds)
        except Exception as e:
            # Provide clearer error if shapes mismatch
            raise RuntimeError(f"Failed to set model params from ndarrays: {e}")

        total_loss = 0.0
        total_correct = 0
        total_examples = 0
        with torch.no_grad():
            for xb, yb in self.val_loader:
                xb = xb.to(self.device)
                yb = yb.to(self.device)
                out = model(xb)
                loss = self.criterion(out, yb)
                batch = yb.size(0)
                total_loss += loss.item() * batch
                preds = out.argmax(dim=1)
                total_correct += (preds == yb).sum().item()
                total_examples += batch
        if total_examples == 0:
            raise RuntimeError("Validation loader has zero examples.")
        return total_loss / total_examples, total_correct / total_examples

    # ---------- main override ----------
    def aggregate_fit(self, rnd: int, results: List[Tuple[Any, Any]], failures: List[BaseException]) -> Optional[Parameters]:
        if not results:
            return super().aggregate_fit(rnd, results, failures)

        # Collect clients (simple IDs) and their ndarrays + num_examples
        client_ids = []
        client_ndarrays = []
        client_num_examples = []
        client_proxies = []
        for idx, (client_proxy, fit_res) in enumerate(results):
            cid = f"client{idx}"
            client_ids.append(cid)
            client_proxies.append(client_proxy)
            nds = parameters_to_ndarrays(fit_res.parameters)
            client_ndarrays.append(nds)
            num_examples = getattr(fit_res, "num_examples", None) or getattr(fit_res, "num_examples_fit", None)
            if num_examples is None:
                metrics = getattr(fit_res, "metrics", None)
                if isinstance(metrics, dict):
                    num_examples = metrics.get("num_examples")
            client_num_examples.append(float(num_examples or 1))

        # Get global parameters ndarrays
        global_ndarrays = self._get_global_ndarrays_fallback(client_ndarrays[0] if client_ndarrays else None)

        if global_ndarrays is None:
            return super().aggregate_fit(rnd, results, failures)

        self.global_ndarrays = global_ndarrays  # keep current global

        # Flatten and compute deltas
        global_flat = self._flatten_ndarrays(global_ndarrays)
        client_flats = [self._flatten_ndarrays(nds) for nds in client_ndarrays]
        deltas = [cf - global_flat for cf in client_flats]

        # Compute average update for cosine similarity
        stack_deltas = np.stack(deltas)
        avg_update = np.mean(stack_deltas, axis=0)
        avg_norm = np.linalg.norm(avg_update) + 1e-12

        # Compute per-client validation loss if we apply their update (global + delta)
        # and cosine similarity. Score = delta_val_loss + alpha_cos * (1 - cos_sim)
        scores = []
        val_losses = []
        cos_sims = []
        for i, nds in enumerate(client_ndarrays):
            # Produce candidate global + delta as ndarrays list
            candidate_nds = []
            # candidate_nds are just client_ndarrays[i] (the client parameters after local training)
            candidate_nds = client_ndarrays[i]

            # Evaluate server-side validation loss for this candidate
            try:
                val_loss, val_acc = self._evaluate_ndarrays_on_validation(candidate_nds)
            except Exception as e:
                # If evaluation fails, mark as suspicious by setting large loss
                print(f"[PIDFedAvg] Warning: validation eval failed for {client_ids[i]}: {e}")
                val_loss = float("inf")
                val_acc = 0.0

            val_losses.append(val_loss)

            # Cosine similarity between this delta and avg_update
            cos_sim = (np.dot(deltas[i], avg_update) / ((np.linalg.norm(deltas[i]) + 1e-12) * avg_norm))
            cos_sims.append(cos_sim)

        # Baseline: compute validation loss of global model (without applying any client)
        try:
            global_val_loss, global_val_acc = self._evaluate_ndarrays_on_validation(global_ndarrays)
        except Exception as e:
            print(f"[PIDFedAvg] Warning: evaluating global model on validation set failed: {e}")
            global_val_loss = np.mean(val_losses) if len(val_losses) > 0 else 0.0

        # Build score: how much validation loss increased relative to global
        for i in range(len(client_ids)):
            # Higher delta_loss = more suspicious if val_loss > global_val_loss
            delta_loss = val_losses[i] - global_val_loss
            # For normalization, clamp or leave as is; we can use raw delta_loss
            score = delta_loss + self.alpha_cos * (1.0 - cos_sims[i])
            scores.append(score)

        scores = np.array(scores, dtype=np.float64)

        # ========== Diagnostic print (you can inspect these) ==========
        print(f"\n[PIDFedAvg][Round {rnd}] Diagnostics:")
        print(f"  global_val_loss={global_val_loss:.6g}")
        for i, cid in enumerate(client_ids):
            print(f"  {cid}: val_loss={val_losses[i]:.6g}, cos_sim={cos_sims[i]:.6g}, score={scores[i]:.6g}")
        # =============================================================

        # PID smoothing (apply PID to the score)
        pids = []
        for cid, score in zip(client_ids, scores):
            state = self.client_pid_state.setdefault(cid, {"integral": 0.0, "prev": 0.0})
            state["integral"] += float(score)
            derivative = float(score) - float(state["prev"])
            pid_score = float(self.k * score + self.ki * state["integral"] + self.kd * derivative)
            state["prev"] = float(score)
            self.client_pid_state[cid] = state
            pids.append(pid_score)
        pids = np.array(pids, dtype=np.float64)

        # Robust thresholding (MAD, fallback to percentile)
        median = np.median(pids)
        mad = np.median(np.abs(pids - median))
        if mad > 0:
            cutoff = median + self.mad_multiplier * mad
            reason = f"MAD (median={median:.6g}, MAD={mad:.6g})"
        else:
            cutoff = np.percentile(pids, self.prune_percentile)
            reason = f"Percentile {self.prune_percentile}"

        # Warmup: skip pruning until a few rounds have passed
        if rnd < self.start_pruning_round:
            print(f"[PIDFedAvg] Round {rnd}: warming up (no pruning).")
            agg_result = super().aggregate_fit(rnd, results, failures)
            aggregated_parameters, aggregated_metrics = self._unpack_agg_result(agg_result)
            if aggregated_parameters is not None:
                try:
                    self.global_ndarrays = parameters_to_ndarrays(aggregated_parameters)
                    self.parameters = aggregated_parameters
                except Exception as e:
                    print(f"[PIDFedAvg] Warning: could not set global_ndarrays after warmup: {e}")
            return agg_result

        # Determine pruned clients
        pruned_indices = []
        if len(results) >= self.min_clients_to_prune:
            pruned_indices = [i for i, pid in enumerate(pids) if pid > cutoff]
            # avoid pruning everyone
            max_prune = max(0, len(results) - 1)
            if len(pruned_indices) > max_prune:
                # prune the top-most suspicious up to max_prune
                sorted_idx = np.argsort(-pids)
                pruned_indices = sorted_idx[:max_prune].tolist()

        clean_clients = [(cp, fr) for i, (cp, fr) in enumerate(results) if i not in pruned_indices]
        pruned_clients = [client_ids[i] for i in pruned_indices]

        # Logging
        print(f"\n[PIDFedAvg] Round {rnd}: total={len(results)}, pruned={len(pruned_clients)} ({reason}), cutoff={cutoff:.6g}")
        for i, cid in enumerate(client_ids):
            status = "PRUNED" if i in pruned_indices else "OK"
            print(f"  {cid}: pid={pids[i]:.6g}, score={scores[i]:.6g}, val_loss={val_losses[i]:.6g}, cos_sim={cos_sims[i]:.6g}, {status}")

        # Aggregate only clean clients and return what parent returns
        agg_result = super().aggregate_fit(rnd, clean_clients, failures)
        aggregated_parameters, aggregated_metrics = self._unpack_agg_result(agg_result)
        if aggregated_parameters is not None:
            try:
                self.global_ndarrays = parameters_to_ndarrays(aggregated_parameters)
                self.parameters = aggregated_parameters
            except Exception as e:
                print(f"[PIDFedAvg] Warning: could not set global_ndarrays after aggregation: {e}")
        return agg_result

    # Helper - obtains global ndarrays, falling back if necessary
    def _get_global_ndarrays_fallback(self, fallback_ndarrays=None):
        if getattr(self, "parameters", None) is not None:
            try:
                return parameters_to_ndarrays(self.parameters)
            except Exception:
                pass
        # fallback: use last stored or provided
        if self.global_ndarrays is not None:
            return self.global_ndarrays
        return fallback_ndarrays
