#!/bin/bash

#DOCKER
#Var(s)
USER=vagrant
#Install
yum install yum-utils device-mapper-persistent-data lvm2 -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl enable --now docker
docker run hello-world
# https://docs.docker.com/engine/install/linux-postinstall/
sudo usermod -aG docker $USER