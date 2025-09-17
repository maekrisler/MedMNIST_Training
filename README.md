
# Setup instructions to run the model

pip install monai
pip install torch
pip install datasets
pip install filelock
pip install flwr-datasets


# Before running the model, check rounds/CPU/GPU settings in pyptoject.toml

[tool.flwr.app.config]
num-server-rounds = 50
fraction-fit = 0.5
batch-size = 128

- I have found that running 50 rounds with a toy dataset of 200 images can show sufficent learning without taking 30+ min to run on my laptop

# if you want to train with the entire image set for all classes, remove the following lines in task.py (comment out don't delete please)

  # TOY RUN FOR TESTING
    toy_size = 300
    indices = random.sample(range(len(image_file_list)), toy_size)
    image_file_list = [image_file_list[i] for i in indices]
    image_label_list = [image_label_list[i] for i in indices]