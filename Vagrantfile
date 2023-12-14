# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "kubernetes" do |kubernetes|
    kubernetes.vm.box = "bento/rockylinux-9"
    kubernetes.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = "4"
    end
    kubernetes.vm.network "private_network", ip: "10.10.10.10"
    kubernetes.vm.network "forwarded_port", guest: 8080, host: 8080 #argocd api server
    kubernetes.vm.synced_folder "./shared", "/shared"
    kubernetes.vm.synced_folder "./provision", "/provision"
    kubernetes.vm.provision "shell", inline: "hostnamectl set-hostname vagrant-kubernetes"
    kubernetes.vm.provision "shell", path: "provision/os.sh"
    kubernetes.vm.provision "shell", path: "provision/docker.sh"
    kubernetes.vm.provision "shell", path: "provision/compose.sh"
    kubernetes.vm.provision "shell", path: "provision/minikube.sh"
    kubernetes.vm.provision "shell", path: "provision/snapd_k9s.sh"
    kubernetes.vm.provision "shell", path: "provision/argocd_k8s.sh", privileged: false
    kubernetes.vm.provision "shell", path: "provision/argocd_2_portforward.sh"
    kubernetes.vm.provision "shell", path: "provision/argocd_initial_password.sh", privileged: false
  end
end
