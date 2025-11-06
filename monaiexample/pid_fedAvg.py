# create PID score
from flwr.server.strategy import FedAvg
import numpy as np
from flwr.common import parameters_to_ndarrays

# extend FedAvg to compute and log PID score
# FedAvg defines how server aggregates model updates from clients
# by extending, model updates can be computed and checked for poisoning

class PIDFedAvg(FedAvg):
    def __init__(self, k=1.0, ki=0.05, kd=0.5, threshold=0.01, **kwargs):
        super().__init__(**kwargs)
        self.k = k
        self.ki = ki
        self.kd = kd
        self.threshold = threshold
        self.client_history = {}

    
    def aggregate_fit(self, round, results, failures):
        
        if round < 5:
            return super().aggregate_fit(round, results, failures)

        final_weights = []
        for client_proxy, fit_res in results:
            # convert params object to an array to iterate over
            ndarrays = parameters_to_ndarrays(fit_res.parameters)
            flattened_params = []
            
            for p in ndarrays:
                model_weight = p.ravel()
                flattened_params.extend(model_weight)
            
            final_weights.append(np.array(flattened_params))


        centroid = np.mean(final_weights, axis=0)

        distances = []
        for weights in final_weights:
            distance = 1 - np.dot(weights, centroid) / (np.linalg.norm(weights) * np.linalg.norm(centroid) + 1e-8)
            distances.append(distance)

        pids = []
        for cid, dist in zip([r[0].cid for r in results], distances):
            prev_state = self.client_history.get(cid, {"integral": 0.0, "prev_dist": 0.0, "PID": 0.0})

            P = self.k * dist
            I = 0.9 * prev_state["integral"] + self.ki * dist  # exponential decay
            D = self.kd * (dist - prev_state["prev_dist"])

            PID_value = P + I + D

            self.client_history[cid] = {"integral": I, "prev_dist": dist, "PID": PID_value}

            pids.append((cid, PID_value))

        # get all PIDS to compute new thr for pruning
        pids = [self.client_history[client_proxy.cid]["PID"] for client_proxy, _ in results]

        mean_pid = np.mean(pids)
        std_pid = np.std(pids)
        threshold = mean_pid + std_pid  # instead of mean - std

        clean_clients = []
        for client_proxy, fit_res in results:
            cid = client_proxy.cid
            if self.client_history[cid]["PID"] > threshold:
                # prune suspicious clients
                continue
            clean_clients.append((client_proxy, fit_res))

        print(f"\tRound {round}: Retaining {len(clean_clients)} / {len(results)} clients")
        # Identify pruned clients by index order in this round
        all_cids = [client_proxy.cid for client_proxy, _ in results]
        kept_cids = [client_proxy.cid for client_proxy, _ in clean_clients]
        pruned_cids = [cid for cid in all_cids if cid not in kept_cids]

        # Map to readable client names like "client0", "client1", etc.
        cid_to_simple = {cid: f"client{i}" for i, cid in enumerate(all_cids)}
        pruned_list = [cid_to_simple[cid] for cid in pruned_cids]
        kept_list = [cid_to_simple[cid] for cid in kept_cids]

        print(f"\tRound {round}: Retaining {len(clean_clients)} / {len(results)} clients")
        if pruned_list:
            print(f"\tPruned: {', '.join(pruned_list)}")
        else:
            print("\tPruned: None")

        return super().aggregate_fit(round, clean_clients, failures)