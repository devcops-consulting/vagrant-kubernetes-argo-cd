#!/bin/bash

#Create systemd service
service_file="argocd_portforward.service"
target_path="/etc/systemd/system"
sudo cp /shared/$service_file "$target_path"
sudo systemctl daemon-reload
sudo systemctl enable "$service_file" --now

#kubectl port-forward svc/argocd-server -n argocd 8080:443 --address='0.0.0.0'