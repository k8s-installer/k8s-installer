#!/bin/sh

if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

# Install repo
./install-repo.sh

# Install and start docker
./install-docker.sh

# Install kubelet and start
./install-kubeadm.sh

# Load images
./load-images.sh
