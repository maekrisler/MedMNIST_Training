# create PID score
from flwr.server.strategy import FedAvg
import numpy as np
from flwr.common import parameters_to_ndarrays

class PIDFedAvg(FedAvg):
    def __init__(self, k=1.5, ki=0.1, kd=0.8, **kwargs):
        super().__init__(**kwargs)
        self.k = k  # Proportional gain
        self.ki = ki  # Integral gain  
        self.kd = kd  # Derivative gain
        self.client_history = {}
        self.client_name_map = {}
        self.client_counter = 0

    def aggregate_fit(self, round, results, failures):
        if not results:
            return super().aggregate_fit(round, results, failures)
        
        final_weights = []
        client_ids = []
        
        # Process client updates and create mapping
        for client_proxy, fit_res in results:
            cid = client_proxy.cid
            client_ids.append(cid)
            
            # Map to simple names for logging
            if cid not in self.client_name_map:
                self.client_name_map[cid] = f"client{self.client_counter}"
                self.client_counter += 1
            
            # Convert parameters to numpy arrays
            ndarrays = parameters_to_ndarrays(fit_res.parameters)
            flattened_params = []
            
            for p in ndarrays:
                model_weight = p.ravel()
                flattened_params.extend(model_weight)
            
            final_weights.append(np.array(flattened_params))

        # Calculate centroid (average model)
        centroid = np.mean(final_weights, axis=0)
        centroid_norm = np.linalg.norm(centroid)
        
        # Avoid division by zero
        if centroid_norm == 0:
            centroid_norm = 1e-10

        # Calculate distances and PID scores
        distances = []
        current_pids = []
        
        for i, weights in enumerate(final_weights):
            cid = client_ids[i]
            
            # Calculate normalized distance from centroid
            distance = np.linalg.norm(weights - centroid) / centroid_norm
            #distance = np.linalg.norm(weights - centroid) / (np.linalg.norm(centroid) + 1e-8)  # Add epsilon
            distances.append(distance)
            
            # Get previous state or initialize
            prev_state = self.client_history.get(cid, {
                "integral": 0.0, 
                "prev_dist": 0.0, 
                "PID": 0.0
            })
            
            # PID calculation
            P = self.k * distance  # Proportional term
            I = prev_state["integral"] + self.ki * distance  # Integral term
            D = self.kd * (distance - prev_state["prev_dist"])  # Derivative term
            
            PID_value = P + I + D
            
            # Update history
            self.client_history[cid] = {
                "integral": I, 
                "prev_dist": distance, 
                "PID": PID_value
            }
            
            current_pids.append(PID_value)

        # Calculate adaptive threshold for pruning (HIGH PID = suspicious)
        mean_pid = np.mean(current_pids)
        std_pid = np.std(current_pids)
        
        # Prune clients with PID scores ABOVE threshold (outliers)
        threshold = mean_pid + 1.5 * std_pid  # More aggressive threshold
        
        clean_clients = []
        pruned_clients = []
        
        for i, (client_proxy, fit_res) in enumerate(results):
            cid = client_ids[i]
            client_pid = current_pids[i]
            
            if client_pid > threshold:
                pruned_clients.append(self.client_name_map[cid])
            else:
                clean_clients.append((client_proxy, fit_res))

        # Logging
        if pruned_clients:
            print(f"\tRound {round}: Pruned suspicious clients: {', '.join(pruned_clients)}")
            print(f"\tRound {round}: PID threshold = {threshold:.6f}")
            # Optional: Print PID scores for debugging
            for i, cid in enumerate(client_ids):
                print(f"\t  {self.client_name_map[cid]}: PID = {current_pids[i]:.6f}, Distance = {distances[i]:.6f}")
        
        print(f"\tRound {round}: Retaining {len(clean_clients)} / {len(results)} clients")
        
        return super().aggregate_fit(round, clean_clients, failures)