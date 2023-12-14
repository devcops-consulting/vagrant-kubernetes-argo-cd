#!/bin/bash

COMMAND="minikube kubectl --"
#COMMAND="kubectl"
#$COMMAND get secret argocd-initial-admin-secret -n argocd -o yaml | grep 'password:' | awk '{print $2}' | base64 --decode

# Function to get the ArgoCD initial admin password
get_argocd_password() {
    echo "$($COMMAND get secret argocd-initial-admin-secret -n argocd -o yaml 2>/dev/null | grep 'password:' | awk '{print $2}' | base64 --decode)"
}

# Initial password retrieval
INITIAL_PASSWORD=$(get_argocd_password)

# Wait for the secret to be created if not found initially
MAX_WAIT=180 # Maximum wait time in seconds
INTERVAL=10  # Time interval between checks in seconds
ELAPSED=0   # Elapsed time counter

while [ -z "$INITIAL_PASSWORD" ] && [ $ELAPSED -lt $MAX_WAIT ]; do
    echo "Waiting for ArgoCD initial admin secret to be created..."
    sleep $INTERVAL
    ELAPSED=$((ELAPSED + INTERVAL))
    INITIAL_PASSWORD=$(get_argocd_password)
done


echo "ArgoCD UI: https://10.10.10.10:8080" | tee -a /shared/argocd.txt
echo "ArgoCD CLI: argocd login" | tee -a /shared/argocd.txt
echo "Username: admin" | tee -a /shared/argocd.txt
echo "Initial Password: $INITIAL_PASSWORD" | tee -a /shared/argocd.txt

# Check if the password was not retrieved
if [ -z "$INITIAL_PASSWORD" ]; then
    echo "Failed to retrieve the initial password within the maximum wait time. Possibly you need to run manually this script - $0."
fi
