"""monaiexample: A Flower / MONAI app."""

import torch
from flwr.client import ClientApp, NumPyClient
from flwr.common import Context
from flwr.server.strategy import FedAvg
import os
import csv

from monaiexample.task import get_params, load_data, load_model, set_params, test, train

LOG_FILE = "client_metrics.csv"

# Create CSV header once
if not os.path.exists(LOG_FILE):
    with open(LOG_FILE, mode="w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["Client", "Round", "Accuracy", "Loss"])

# -------------------------
# Custom FedAvg strategy to pass the current round to clients
# -------------------------
class FedAvgWithRound(FedAvg):
    def configure_fit(self, rnd, parameters, client_manager):
        # Pass current round number to each client
        config = {"server_round": rnd}
        return super().configure_fit(rnd, parameters, client_manager, config=config)

    def configure_evaluate(self, rnd, parameters, client_manager):
        # Pass current round number to each client
        config = {"server_round": rnd}
        return super().configure_evaluate(rnd, parameters, client_manager, config=config)

# -------------------------
# Flower client
# -------------------------
class FlowerClient(NumPyClient):
    def __init__(self, net, trainloader, valloader, cid: str):
        self.net = net
        self.trainloader = trainloader
        self.valloader = valloader
        self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
        self.cid = cid

    def fit(self, parameters, config):
        set_params(self.net, parameters)
        train(self.net, self.trainloader, epoch_num=1, device=self.device)
        return get_params(self.net), len(self.trainloader.dataset), {}

    def evaluate(self, parameters, config):
        # Correct round number from server
        round_num = config.get("server_round", 0)
        set_params(self.net, parameters)
        loss, accuracy = test(self.net, self.valloader, self.device)

        # Append result to shared CSV
        with open(LOG_FILE, mode="a", newline="") as f:
            writer = csv.writer(f)
            writer.writerow([self.cid, round_num, accuracy, loss])

        return loss, len(self.valloader.dataset), {"accuracy": accuracy, "loss": loss}

# -------------------------
# Client factory
# -------------------------
def client_fn(context: Context):
    # Use partition-id as unique client ID
    cid = str(context.node_config["partition-id"])
    partition_id = context.node_config["partition-id"]
    num_partitions = context.node_config["num-partitions"]
    batch_size = context.run_config["batch-size"]

    trainloader, valloader = load_data(
        num_partitions, partition_id, batch_size, percent_flipped=0.5
    )
    net = load_model()

    return FlowerClient(net, trainloader, valloader, cid=cid).to_client()

# -------------------------
# Client app
# -------------------------
app = ClientApp(client_fn=client_fn)
