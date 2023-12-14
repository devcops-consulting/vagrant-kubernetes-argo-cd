#!/bin/bash

#COMPOSE
#Var(s)
VERSION="v2.22.0" #https://github.com/docker/compose/releases/tag/v2.22.0 2023.09.24
#Install
sudo curl -L "https://github.com/docker/compose/releases/download/$VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose