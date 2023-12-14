#!/bin/bash

#https://minikube.sigs.k8s.io/docs/start/
# Leave it empty for the latest version
#MINIKUBE_VERSION=""
#MINIKUBE_VERSION=v1.32.0 #2023.12
# Check if a specific version of Minikube is set
if [ -z "$MINIKUBE_VERSION" ]; then
    # No version specified, use the latest version
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
else
    # Specific version is specified, use the GitHub URL
    curl -LO https://github.com/kubernetes/minikube/releases/download/${MINIKUBE_VERSION}/minikube-linux-amd64
fi
sudo install minikube-linux-amd64 /usr/local/bin/minikube

#Create systemd service
service_file="minikube.service"
target_path="/etc/systemd/system"
sudo cp /shared/$service_file "$target_path"
sudo systemctl daemon-reload
sudo systemctl enable "$service_file" --now




alias_command="alias kubectl='minikube kubectl --'"

# File to append the alias
file_to_append="/etc/bashrc"

# Check if the alias already exists in the file
if grep -q "$alias_command" "$file_to_append"; then
    echo "Alias already exists in $file_to_append"
else
    # Append the alias to the file
    echo "$alias_command" >> "$file_to_append"
    echo "Alias added to $file_to_append"
fi

sleep 30

# Update PATH to include /usr/local/bin
export PATH=$PATH:/usr/local/bin

#Install appropriate version of kubectl by minikube





#minikube kubectl -- get po -A

# changes in /etc/bashrc will only take effect for new sessions, so users will need to log out and log back in, or source the file manually for immediate effect.

#kubectl get po -A can be applied after profile actiavbted (new session)