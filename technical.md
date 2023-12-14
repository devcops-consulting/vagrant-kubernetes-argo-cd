# Technical Details about the Solution

## Provision Folder

### os.sh

The [provision/os.sh](provision/os.sh) script is responsible for installing essential packages. Currently, the most crucial step is to ensure that the `epel-release` package is available, as it provides an additional repository for further application installations.

`epel-release` stands for **Extra **P**ackages for **E**nterprise **L**inux** and offers a collection of commonly used packages for Red Hat-based distributions.

### docker.sh

The [provision/docker.sh](provision/docker.sh) script installs Docker-CE: [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/), the Community Edition of Docker, enabling the execution of Docker images on the host machine.

Kubernetes, a popular container orchestration platform, commonly relies on Docker as its virtualization engine. This script installs Docker, its dependencies, starts it, and sets it to autostart on the host. Additionally, the `vagrant` user (the default user in the host OS) is added to the Docker group to grant permission to manage Docker images.
