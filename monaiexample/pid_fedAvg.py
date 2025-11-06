from flwr.server.strategy import FedAvg
import numpy as np
from flwr.common import parameters_to_ndarrays
import pandas as pd
import os
from datetime import datetime

class PIDFedAvg(FedAvg):
    def __init__(self, k=1.0, ki=0.05, kd=0.5, threshold_multiplier=2.0, start_pruning_round=10, **kwargs):
        super().__init__(**kwargs)
        self.k = k
        self.ki = ki
        self.kd = kd
        self.threshold_multiplier = threshold_multiplier
        self.start_pruning_round = start_pruning_round
        self.client_history = {}
        self.client_name_map = {}
        self.next_client_id = 0
        self.expected_malicious = set()  # Track expected malicious clients
        
        # Initialize PID logging CSV
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        self.pid_csv = f"pid_scores_{timestamp}.csv"
        if not os.path.exists(self.pid_csv):
            pd.DataFrame(columns=[
                "Round", "Client", "Distance", "P", "I", "D", "PID", 
                "Threshold", "Status", "Pruning_Active", "Expected_Malicious"
            ]).to_csv(self.pid_csv, index=False)

    def _get_simple_client_name(self, original_cid):
        """Map original client ID to simple name like client0, client1, etc."""
        if original_cid not in self.client_name_map:
            simple_name = f"client{self.next_client_id}"
            self.client_name_map[original_cid] = simple_name
            
            # Mark first 4 clients as expected malicious (based on your client_app logic)
            if self.next_client_id < 4:
                self.expected_malicious.add(simple_name)
                print(f"ðŸ”´ Expected malicious client: {simple_name} (original ID: {original_cid})")
            
            self.next_client_id += 1
        return self.client_name_map[original_cid]

    def aggregate_fit(self, round, results, failures):
        if not results:
            return super().aggregate_fit(round, results, failures)

        # Convert all client parameters to flattened arrays
        client_weights = []
        for client_proxy, fit_res in results:
            ndarrays = parameters_to_ndarrays(fit_res.parameters)
            flattened_params = np.concatenate([p.ravel() for p in ndarrays])
            client_weights.append(flattened_params)

        # **KEY FIX: Iterative centroid calculation**
        # First pass - calculate initial centroid with all clients
        initial_centroid = np.median(client_weights, axis=0)
        initial_distances = []
        for weights in client_weights:
            distance = np.linalg.norm(weights - initial_centroid) / (np.linalg.norm(initial_centroid) + 1e-8)
            initial_distances.append(distance)
        
        # Identify potential outliers for exclusion from refined centroid
        mean_dist = np.mean(initial_distances)
        std_dist = np.std(initial_distances)
        outlier_threshold = mean_dist + 1.5 * std_dist
        
        clean_weights = []
        for i, dist in enumerate(initial_distances):
            if dist <= outlier_threshold:
                clean_weights.append(client_weights[i])
        
        # Calculate refined centroid without strong outliers
        if len(clean_weights) > 0:
            refined_centroid = np.mean(clean_weights, axis=0)
        else:
            refined_centroid = initial_centroid
        
        # Use refined centroid for PID calculations
        distances = []
        for weights in client_weights:
            distance = np.linalg.norm(weights - refined_centroid) / (np.linalg.norm(refined_centroid) + 1e-8)
            distances.append(distance)

        # Update PID scores and collect data
        pid_data = []
        for (client_proxy, _), dist in zip(results, distances):
            cid = client_proxy.cid
            simple_name = self._get_simple_client_name(cid)
            
            prev_state = self.client_history.get(cid, {
                "integral": 0.0, 
                "prev_dist": dist,
                "PID": 0.0,
                "simple_name": simple_name
            })

            # PID components
            P = self.k * dist
            I = prev_state["integral"] + self.ki * dist
            D = self.kd * (dist - prev_state["prev_dist"])
            PID_value = P + I + D

            # Update history
            self.client_history[cid] = {
                "integral": I,
                "prev_dist": dist,
                "PID": PID_value,
                "simple_name": simple_name
            }
            
            pid_data.append({
                "simple_name": simple_name,
                "original_cid": cid,
                "distance": dist,
                "P": P,
                "I": I,
                "D": D,
                "PID": PID_value
            })

        # Calculate threshold (always calculate for monitoring)
        pids = [data["PID"] for data in pid_data]
        mean_pid = np.mean(pids)
        std_pid = np.std(pids)
        new_thr = mean_pid + self.threshold_multiplier * std_pid

        # Determine if pruning is active
        pruning_active = round >= self.start_pruning_round
        
        # Print detailed information
        print(f"\n=== Round {round} PID Scores ===")
        if pruning_active:
            print(f"ðŸš€ PRUNING ACTIVE - Threshold: {new_thr:.6f} (Mean: {mean_pid:.6f}, Std: {std_pid:.6f})")
        else:
            print(f"ðŸ“Š MONITORING ONLY (Pruning starts at round {self.start_pruning_round}) - Threshold: {new_thr:.6f} (Mean: {mean_pid:.6f}, Std: {std_pid:.6f})")
        
        print("-" * 80)
        print(f"{'Client':<12} {'Distance':<12} {'P':<12} {'I':<12} {'D':<12} {'PID':<12} {'Status':<10}")
        print("-" * 80)
        
        # Save PID data to CSV and determine which clients to keep
        csv_rows = []
        clean_clients = []
        malicious_count = 0
        
        # In the printing section, add expected malicious info:
        for (client_proxy, fit_res), data in zip(results, pid_data):
            cid = client_proxy.cid
            client_pid = data["PID"]
            simple_name = data['simple_name']
            
            # Only classify as malicious if pruning is active AND PID exceeds threshold
            is_malicious = pruning_active and (client_pid > new_thr)
            is_expected_malicious = simple_name in self.expected_malicious
            
            status = "MALICIOUS" if is_malicious else "NORMAL"
            expected_flag = " ðŸ”´" if is_expected_malicious else " âœ…"
            status_display = f"**{status}**" if is_malicious else status
            
            print(f"{simple_name:<12} {data['distance']:.6f}   {data['P']:.6f}   {data['I']:.6f}   {data['D']:.6f}   {data['PID']:.6f}   {status_display:<10}{expected_flag}")
            
            # Save to CSV
            csv_rows.append({
                "Round": round,
                "Client": simple_name,
                "Distance": data['distance'],
                "P": data['P'],
                "I": data['I'],
                "D": data['D'],
                "PID": data['PID'],
                "Threshold": new_thr,
                "Status": status,
                "Pruning_Active": pruning_active,
                "Expected_Malicious": is_expected_malicious
            })
            
            if is_malicious:
                malicious_count += 1
                if pruning_active:
                    print(f"   â†’ Pruning {data['simple_name']} (PID: {client_pid:.6f})")
            else:
                clean_clients.append((client_proxy, fit_res))

        # Append to CSV file
        pd.DataFrame(csv_rows).to_csv(self.pid_csv, mode='a', header=False, index=False)
        
        print("-" * 80)
        if pruning_active:
            print(f"ðŸš€ PRUNING ACTIVE: {len(clean_clients)} normal clients, {malicious_count} malicious clients pruned")
        else:
            print(f"ðŸ“Š MONITORING: {len(results)} clients (pruning starts at round {self.start_pruning_round})")
            # In monitoring mode, keep all clients
            clean_clients = results
        
        print(f"PID scores saved to: {self.pid_csv}")
        print("=" * 80)

        # Fallback if all clients pruned (shouldn't happen in monitoring mode)
        if not clean_clients and pruning_active:
            print(f"âš ï¸  Warning: All clients pruned in round {round}. Using all clients as fallback.")
            clean_clients = results

        return super().aggregate_fit(round, clean_clients, failures)