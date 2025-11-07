"""monaiexample: A Flower / MONAI app."""

import torch
from flwr.client import ClientApp, NumPyClient
from flwr.common import Context

from monaiexample.task import get_params, load_data, load_model, set_params, test, train
# from task import get_params, load_data, load_model, set_params, test, train

# Define Flower client
# Define Flower client
class FlowerClient(NumPyClient):
    def __init__(self, net, trainloader, valloader, client_id):
        self.net = net
        self.trainloader = trainloader
        self.valloader = valloader
        self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
        self.client_id = client_id  # Store the client ID

    def fit(self, parameters, config):
        set_params(self.net, parameters)
        train(self.net, self.trainloader, epoch_num=3, device=self.device)
        return get_params(self.net), len(self.trainloader), {}

    def evaluate(self, parameters, config):
        set_params(self.net, parameters)
        loss, accuracy = test(self.net, self.valloader, self.device)
        # Include client ID in metrics so server can track it
        return loss, len(self.valloader), {
            "accuracy": accuracy, 
            "loss": loss,
            "client_id": self.client_id  # Add this line
        }


def client_fn(context: Context):
    # get configurations from pyproject.toml file
    # partition id defines what client is sampling the data
    partition_id = context.node_config["partition-id"]
    num_partitions = context.node_config["num-partitions"]

    batch_size = context.run_config["batch-size"]
    # added params for data poisoning
    # poison 4 out of the 20 total clients 
    if partition_id < 4:
        percent_flipped = context.run_config.get("percent-flipped", 0.0)
    else:
        percent_flipped = 0.0

    trainloader, valloader = load_data(num_partitions, partition_id, batch_size, percent_flipped)
    net = load_model()
    
    # Create client ID that matches Flower's format
    client_id = f"client_{partition_id}"
    
    return FlowerClient(net, trainloader, valloader, client_id).to_client()


app = ClientApp(client_fn=client_fn)