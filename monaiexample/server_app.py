"""monaiexample: A Flower / MONAI app."""

from typing import List, Tuple

from flwr.common import Context, Metrics, ndarrays_to_parameters
from flwr.server import ServerApp, ServerAppComponents, ServerConfig
from flwr.server.strategy import FedAvg
import pandas as pd
import os
import datetime

from monaiexample.task import get_params, load_model

results = []
CSV_FILE = "results.csv"

# --- Create a unique filename for each run ---
timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
CSV_FILE = f"results_{timestamp}.csv"

def weighted_average(metrics: List[Tuple[int, Metrics]]) -> Metrics:
    # Separate accuracy and loss values (if provided by clients)
    accuracies = []
    losses = []
    examples = []
    
    for num_examples, m in metrics:
        examples.append(num_examples)
        if "accuracy" in m:
            accuracies.append(num_examples * m["accuracy"])
        if "loss" in m:
            losses.append(num_examples * m["loss"])

    total_examples = sum(examples)

    # Compute weighted averages
    avg_accuracy = sum(accuracies) / total_examples if accuracies else None
    avg_loss = sum(losses) / total_examples if losses else None

    if os.path.exists(CSV_FILE):
        existing = pd.read_csv(CSV_FILE)
        round_num = existing.shape[0] + 1
        header = False
    else:
        round_num = 1
        header = True

    # Prepare a new row
    row = {"round": round_num}
    if avg_accuracy is not None:
        row["accuracy"] = avg_accuracy
    if avg_loss is not None:
        row["loss"] = avg_loss

    # Append to CSV
    df = pd.DataFrame([row])
    df.to_csv(CSV_FILE, mode="a", header=header, index=False)
    return {"accuracy": sum(accuracies) / sum(examples)}


def server_fn(context: Context):

    # Init model
    model = load_model()

    # Convert model parameters to flwr.common.Parameters
    ndarrays = get_params(model)
    global_model_init = ndarrays_to_parameters(ndarrays)

    # Define strategy
    fraction_fit = context.run_config["fraction-fit"]
    strategy = FedAvg(
        fraction_fit=fraction_fit,
        evaluate_metrics_aggregation_fn=weighted_average,
        initial_parameters=global_model_init,
    )

    # Construct ServerConfig
    num_rounds = context.run_config["num-server-rounds"]
    config = ServerConfig(num_rounds=num_rounds)

    return ServerAppComponents(strategy=strategy, config=config)


app = ServerApp(server_fn=server_fn)
