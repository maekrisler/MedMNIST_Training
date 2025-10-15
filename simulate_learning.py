import subprocess, os

project_dir = os.path.dirname(__file__)
# get paths to server and client app
server_path = os.path.join(project_dir, "monaiexample", "server_app.py")
client_path = os.path.join(project_dir, "monaiexample", "client_app.py")

# start flower server
# server = subprocess.Popen(["python3", server_path],
#                           stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
server = subprocess.Popen(["python3", "-m", "monaiexample.server_app"])


# print(server.stdout.read().decode())

# start clients
# TODO: get cmd line args for data flippingfl
# TODO: specify number of clients to poison

num_clients = 2

clients = []
for i in range(num_clients):
    client = subprocess.Popen(
        ["python3", "-m", "monaiexample.client_app",
        "--partition-id", str(i), "--percent-flipped", "0.5"])
    
    clients.append(client)

# wait for all clients to finish
for client in clients:
    client.wait()


# end after training
server.terminate()