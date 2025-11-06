"""monaiexample: A Flower / MONAI app."""

from typing import List, Tuple
from flwr.common import Context, Metrics, ndarrays_to_parameters
from flwr.server import ServerApp, ServerAppComponents, ServerConfig
from flwr.server.strategy import FedAvg
from monaiexample.pid_fedAvg import PIDFedAvg
import pandas as pd
import os
import datetime

from monaiexample.task import get_params, load_model
# from task import get_params, load_model


timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
AGG_CSV = f"results_{timestamp}.csv"          # Aggregated (global) results
CLIENT_CSV = f"client_metrics_{timestamp}.csv"  # Per-client results

# Initialize both CSVs
if not os.path.exists(AGG_CSV):
    pd.DataFrame(columns=["Round", "AvgAccuracy", "AvgLoss"]).to_csv(AGG_CSV, index=False)
if not os.path.exists(CLIENT_CSV):
    pd.DataFrame(columns=["Client", "Round", "Accuracy", "Loss"]).to_csv(CLIENT_CSV, index=False)


def weighted_average(metrics: List[Tuple[int, Metrics]]) -> Metrics:
    """
    Called once per round after all clients report their results.
    Logs per-client metrics and computes weighted global averages.
    """

    # Determine current round number based on existing aggregate CSV
    if os.path.exists(AGG_CSV):
        existing = pd.read_csv(AGG_CSV)
        round_num = int(existing["Round"].max() + 1) if not existing.empty else 1
    else:
        round_num = 1

    total_examples = 0
    weighted_acc_sum = 0.0
    weighted_loss_sum = 0.0
    client_rows = []

    # Process result for each client
    for client_idx, (num_examples, m) in enumerate(metrics):
        acc = m.get("accuracy", None)
        loss = m.get("loss", None)

        client_rows.append({
            "Client": client_idx,
            "Round": round_num,
            "Accuracy": acc,
            "Loss": loss,
        })

        if acc is not None:
            weighted_acc_sum += acc * num_examples
        if loss is not None:
            weighted_loss_sum += loss * num_examples
        total_examples += num_examples

    # Write per client
    if client_rows:
        pd.DataFrame(client_rows).to_csv(CLIENT_CSV, mode="a", header=False, index=False)

    # Compute and save aggregate
    avg_accuracy = weighted_acc_sum / total_examples if total_examples > 0 else None
    avg_loss = weighted_loss_sum / total_examples if total_examples > 0 else None

    agg_row = pd.DataFrame([{
        "Round": round_num,
        "AvgAccuracy": avg_accuracy,
        "AvgLoss": avg_loss,
    }])
    agg_row.to_csv(AGG_CSV, mode="a", header=False, index=False)

    return {"accuracy": avg_accuracy, "loss": avg_loss}


def server_fn(context: Context):
    # Initialize global model
    model = load_model()
    ndarrays = get_params(model)
    global_model_init = ndarrays_to_parameters(ndarrays)

    # Define strategy using FedAvg
    fraction_fit = context.run_config["fraction-fit"]
    # Extend FedAvg to prune malicious clients using PID score
    strategy = PIDFedAvg(k=1.0, ki=0.01, kd=0.1, threshold=0.01,
        fraction_fit=fraction_fit,
        evaluate_metrics_aggregation_fn=weighted_average,
        initial_parameters=global_model_init,
    )

    # TODO : uncomment to use without PID detection and pruning
    # strategy = FedAvg(
    #     fraction_fit=fraction_fit,
    #     evaluate_metrics_aggregation_fn=weighted_average,
    #     initial_parameters=global_model_init,
    # )

    # Configure server rounds
    num_rounds = context.run_config["num-server-rounds"]
    config = ServerConfig(num_rounds=num_rounds)

    return ServerAppComponents(strategy=strategy, config=config)


# Create server app
app = ServerApp(server_fn=server_fn)
