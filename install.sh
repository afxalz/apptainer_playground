#!/bin/bash

# Exit the script if any command fails
set -e

# the traps make sure the script notifies the use which command has failed
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# install pkgs needed for cool shell visualizations
sudo apt install -y \
    toilet \
    dialog

toilet "Removing old version of Docker"
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do apt remove $pkg; done

toilet "Adding Docker's official GPG key"
apt update
apt install -y \
    ca-certificates \
    curl
apt install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

toilet "Adding Docker's the repository to Apt sources"
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
    tee /etc/apt/sources.list.d/docker.list >/dev/null
apt update -y

toilet "Installing Docker"
apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

toilet "Adding $USER to the Docker group"
usermod -a -G docker "$USER" && newgrp docker

# check if docker was installed and the user has access to it
docker run hello-world

toilet "Removing existing Apptainer installation"
apt purge apptainer

toilet "Installing 'apptainer-1.3.8' with fixes for non-root build"
apt install -y wget
cd /tmp && wget https://github.com/apptainer/apptainer/releases/download/v1.3.6/apptainer_1.3.6_amd64.deb
apt install -y ./apptainer_1.3.6_amd64.deb