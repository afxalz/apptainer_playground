#!/bin/bash

# Exit the script if any command fails
set -e

# the traps make sure the script notifies the use which command has failed
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# install pkgs needed for cool shell visualizations
apt-get install -y -q \
    toilet \
    dialog

toilet -w 200 -f smblock "Removing old version of Docker"

DOCKER_DEPS=(
    docker.io
    docker-doc
    docker-compose
    docker-compose-v2
    podman-docker
    containerd
    runc
)

for pkg in $DOCKER_DEPS; do
    apt-get -q -y purge $pkg || true
done

toilet "Adding Docker's official GPG key"
apt-get update
apt-get install -y \
    ca-certificates \
    curl
apt-get install -m 0755 -d /etc/apt-get/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt-get/keyrings/docker.asc
chmod a+r /etc/apt-get/keyrings/docker.asc

toilet "Adding Docker's the repository to Apt sources"
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt-get/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
    tee /etc/apt-get/sources.list.d/docker.list >/dev/null
apt-get update -y

toilet "Installing Docker"
apt-get install -y \
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
apt-get purge apptainer

toilet "Installing 'apptainer-1.3.8' with fixes for non-root build"
apt-get install -y wget
cd /tmp && wget https://github.com/apptainer/apptainer/releases/download/v1.3.6/apptainer_1.3.6_amd64.deb
apt-get install -y ./apptainer_1.3.6_amd64.deb
