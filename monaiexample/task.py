"""monaiexample: A Flower / MONAI app."""

import os
import random
import tarfile
from collections import OrderedDict
from urllib import request

import monai
import torch
from datasets import Dataset
from filelock import FileLock
from flwr_datasets.partitioner import IidPartitioner
from monai.networks.nets import densenet
from monai.transforms import (
    Compose,
    EnsureChannelFirst,
    LoadImage,
    RandFlip,
    RandRotate,
    RandZoom,
    ScaleIntensity,
    NormalizeIntensity,
    ToTensor,
)


def load_model():
    """Load a DenseNet12."""
    return densenet.DenseNet121(spatial_dims=2, in_channels=1, out_channels=6)


def get_params(model):
    """Return tensors in the model's state_dict."""
    return [val.cpu().numpy() for _, val in model.state_dict().items()]


def set_params(model, ndarrays):
    """Apply parameters to a model."""
    params_dict = zip(model.state_dict().keys(), ndarrays)
    state_dict = OrderedDict({k: torch.tensor(v) for k, v in params_dict})
    model.load_state_dict(state_dict, strict=True)


def train(model, train_loader, epoch_num, device):
    """Train a model using the supplied dataloader."""
    model.to(device)
    loss_function = torch.nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), 1e-4)
    for _ in range(epoch_num):
        model.train()
        for batch in train_loader:
            images, labels = batch["img"], batch["label"]
            optimizer.zero_grad()
            loss_function(model(images.to(device)), labels.to(device)).backward()
            optimizer.step()


def test(model, test_loader, device):
    """Evaluate a model on a held-out dataset."""
    model.to(device)
    model.eval()
    loss = 0.0
    y_true = list()
    y_pred = list()
    loss_function = torch.nn.CrossEntropyLoss()
    with torch.no_grad():
        for batch in test_loader:
            images, labels = batch["img"], batch["label"]
            out = model(images.to(device))
            labels = labels.to(device)
            loss += loss_function(out, labels).item()
            pred = out.argmax(dim=1)
            for i in range(len(pred)):
                y_true.append(labels[i].item())
                y_pred.append(pred[i].item())
    accuracy = sum([1 if t == p else 0 for t, p in zip(y_true, y_pred)]) / len(
        test_loader.dataset
    )
    return loss, accuracy


def _get_transforms():
    """Return transforms to be used for training and evaluation."""
    # Compose is a MONAI function for batch data cleaning and preprocessing
    # data is normalized here for better accuracy
    train_transforms = Compose(
        [
            LoadImage(image_only=True),
            EnsureChannelFirst(),
            ScaleIntensity(),
            RandRotate(range_x=15, prob=0.5, keep_size=True),
            RandFlip(spatial_axis=0, prob=0.5),
            RandZoom(min_zoom=0.9, max_zoom=1.1, prob=0.5, keep_size=True),
            ToTensor(),
        ]
    )

    val_transforms = Compose(
        [LoadImage(image_only=True), EnsureChannelFirst(), ScaleIntensity(), ToTensor()]
    )

    return train_transforms, val_transforms


def get_apply_transforms_fn(transforms_to_apply):
    """Return a function that applies the transforms passed as input argument."""

    def apply_transforms(batch):
        """Apply transforms to the partition from FederatedDataset."""
        batch["img"] = [transforms_to_apply(img) for img in batch["img_file"]]
        return batch

    return apply_transforms


ds = None
partitioner = None
poisoned_ds_cache = None

def load_data(num_partitions, partition_id, batch_size, percent_flipped):
    """Download dataset, partition it and return data loader of specific partition."""
    # Set dataset and partitioner only once
    global ds, partitioner # , poisoned_ds_cache
    
    image_file_list, image_label_list = _download_data()
    ds = Dataset.from_dict({"img_file": image_file_list, "label": image_label_list})

    # Split once into clean train/test
    partition_train_test = ds.train_test_split(test_size=0.2, seed=42)
    train_ds = partition_train_test["train"]
    val_ds = partition_train_test["test"]

    # Flip only training labels
    if percent_flipped > 1:
        percent_flipped /= 100.0
    if percent_flipped > 0:
        train_ds = label_flipping(train_ds, percent_flipped)

    # Partition the (potentially flipped) training data
    partitioner = IidPartitioner(num_partitions)
    partitioner.dataset = train_ds
    partition = partitioner.load_partition(partition_id)

    # Apply MONAI transforms
    train_t, val_t = _get_transforms()
    partition_train = partition.with_transform(get_apply_transforms_fn(train_t))
    val_ds = val_ds.with_transform(get_apply_transforms_fn(val_t))

    # DataLoaders
    train_loader = monai.data.DataLoader(partition_train, batch_size=batch_size, shuffle=True)
    val_loader = monai.data.DataLoader(val_ds, batch_size=batch_size)

    return train_loader, val_loader


def label_flipping(ds, percent_flipped):
    """Flip labels for data poisoning attack."""

    # flip labels on the current dataset, don't redo if already done
    labels = ds["label"]
    num_classes = len(set(labels))

    num_to_flip = int(percent_flipped * len(ds))
    indices = random.sample(range(len(ds)), num_to_flip)

    flipped_labels = labels.copy()
    for i in indices:
        original = flipped_labels[i]
        new_label_options = [label for label in range(num_classes) if label != original]
        flipped_labels[i] = random.choice(new_label_options)

    # remap flipped labels
    ds = ds.remove_columns("label").add_column("label", flipped_labels)
    
    return ds



def _download_data():
    """Download and extract dataset."""
    data_dir = "./MedNIST/"
    _download_and_extract_if_needed(
        "https://dl.dropboxusercontent.com/s/5wwskxctvcxiuea/MedNIST.tar.gz",
        os.path.join(data_dir),
    )

    # Compute list of files and thier associated labels
    class_names = sorted(
        [x for x in os.listdir(data_dir) if os.path.isdir(os.path.join(data_dir, x))]
    )

    image_files = [
        [
            os.path.join(data_dir, class_name, x)
            for x in os.listdir(os.path.join(data_dir, class_name))
        ]
        for class_name in class_names
    ]
    image_file_list = []
    image_label_list = []
    for i, _ in enumerate(class_names):
        image_file_list.extend(image_files[i])
        image_label_list.extend([i] * len(image_files[i]))

    # TOY RUN FOR TESTING
    toy_size = 1000
    indices = random.sample(range(len(image_file_list)), toy_size)
    image_file_list = [image_file_list[i] for i in indices]
    image_label_list = [image_label_list[i] for i in indices]

    return image_file_list, image_label_list


def _download_and_extract_if_needed(url, dest_folder):
    """Download dataset if not present."""

    # Logic behind a filelock to prevent multiple processes (e.g. ClientApps)
    # from downloading the dataset at the same time.
    with FileLock(".data_download.lock"):
        if not os.path.isdir(dest_folder):
            # Download the tar.gz file
            tar_gz_filename = url.split("/")[-1]
            if not os.path.isfile(tar_gz_filename):
                with (
                    request.urlopen(url) as response,
                    open(tar_gz_filename, "wb") as out_file,
                ):
                    out_file.write(response.read())

            # Extract the tar.gz file
            with tarfile.open(tar_gz_filename, "r:gz") as tar_ref:
                tar_ref.extractall()
