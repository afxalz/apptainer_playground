#!/bin/bash

echo "Removing existing 'apptainer' installation"
sudo apt purge apptainer

echo "Installing 'apptainer-1.3.8' with fixes for non-root build"
sudo apt update && apt install -y wget
cd /tmp && wget https://github.com/apptainer/apptainer/releases/download/v1.3.6/apptainer_1.3.6_amd64.deb
sudo apt install -y ./apptainer_1.3.6_amd64.deb

