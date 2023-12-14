#!/bin/bash

# Update PATH to include /usr/local/bin
export PATH=$PATH:/usr/local/bin

COMMAND="minikube kubectl --"
#COMMAND="kubectl"

$COMMAND create namespace argocd
$COMMAND apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml