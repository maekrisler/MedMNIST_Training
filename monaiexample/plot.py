import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Read the CSV file
file_path = '/Users/maekrisler/Documents/RIT/year4/secAI/quickstart-monai/client_results/per_client_results20251128_182819.csv'
df = pd.read_csv(file_path)

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

# Get unique clients and rounds
clients = df['Client'].unique()
rounds = sorted(df['Round'].unique())
colors = plt.cm.tab20(np.linspace(0, 1, len(clients)))

# Plot 1: Accuracy per round for each client
for i, client in enumerate(clients):
    client_data = df[df['Client'] == client].sort_values('Round')
    ax1.plot(client_data['Round'].values, client_data['Accuracy'].values, 
             marker='o', label=client, color=colors[i], linewidth=2)

ax1.set_xlabel('Round', fontsize=11)
ax1.set_ylabel('Accuracy', fontsize=11)
ax1.set_title('Model Accuracy per Round by Client', fontsize=12, fontweight='bold')
ax1.grid(True, alpha=0.3)
ax1.legend(bbox_to_anchor=(1.05, 1), loc='upper left', fontsize=9)

# Plot 2: Loss per round for each client
for i, client in enumerate(clients):
    client_data = df[df['Client'] == client].sort_values('Round')
    ax2.plot(client_data['Round'].values, client_data['Loss'].values, 
             marker='s', label=client, color=colors[i], linewidth=2)

ax2.set_xlabel('Round', fontsize=11)
ax2.set_ylabel('Loss', fontsize=11)
ax2.set_title('Model Loss per Round by Client', fontsize=12, fontweight='bold')
ax2.grid(True, alpha=0.3)
ax2.legend(bbox_to_anchor=(1.05, 1), loc='upper left', fontsize=9)

plt.tight_layout()
plt.savefig('training_metrics.png', dpi=300, bbox_inches='tight')
plt.show()

# Print summary statistics
print("Summary Statistics:")
print(f"Average Accuracy: {df['Accuracy'].mean():.3f}")
print(f"Average Loss: {df['Loss'].mean():.4f}")
print(f"Accuracy Range: {df['Accuracy'].min():.3f} - {df['Accuracy'].max():.3f}")
print(f"Loss Range: {df['Loss'].min():.4f} - {df['Loss'].max():.4f}")