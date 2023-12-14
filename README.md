## Bringing Up ArgoCD with Minikube in Rocky Linux 9 with Automated Vagrant Setup

This README provides a guide on how to bring up ArgoCD with Minikube in a Rocky Linux 9 OS using Vagrant with an automated script.

### Prerequisites

Before you begin, ensure you have the following prerequisites installed:

- Vagrant (version 2.6.7 or higher)
- VirtualBox (version 7.0.8 or higher)
- Git

### Setting up the Automated Vagrant Environment

1. Create a directory to house the Vagrant environment:

```bash
mkdir argocd-minikube
cd argocd-minikube
```

2. Clone the repository containing the automation script:

```bash
git clone https://github.com/devcops-consulting/vagrant-kubernetes-argo-cd.git
```

3. Run the automated setup by vagrant:

```bash
vagrant up
```
* Be sure you are inside the cloned folder.

This script will automatically provision the Vagrant VM, install ArgoCD and Minikube, also k9s. For port forwarding systemd service was created, automatically starting.

### Accessing ArgoCD

1. Once the script completes, open a web browser and navigate to the following URL:

```
https://10.10.10.10:8080
```

2. Use the initial admin password printed by the setup script to log in to the ArgoCD web UI.
* In `.\shared\argocd.txt` file it was also stored.

3. Follow the on-screen instructions to configure ArgoCD, including adding your Kubernetes cluster and creating a project to manage your application deployments.

**Congratulations! You have successfully brought up ArgoCD with Minikube in a Rocky Linux 9 OS using Vagrant with automated setup and Windows 11/VirtualBox provider.**

### Tested on

**Fujitsu lifebook U7411**

```bash
Processor: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
Installed Memory: 32GB
OS Information: Microsoft Windows 11 Pro build 22621, 64 bites
Vagrant Version: Vagrant 2.3.7
VirtualBox Version: 7.0.8
VirtualBox Guest Additions Version: VirtualBox 7.0.8 Guest Additions
VM Assigned Memory (GB): 4
VM Assigned CPUs: 4
VM IP Address: 10.10.10.10
VM Forwarded Port: Guest - 8080, Host - 8080
```

### Common issues

**Kernel update**
If you execute `dnf update` it is a possibility that new kernel was available, which required a recompile of guest additions. as a side effect shared mounts, and possilby other features will be broke with this reason.