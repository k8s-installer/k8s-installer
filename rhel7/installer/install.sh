#!/bin/sh

. ./scripts/check-root.sh

# Install repo
./scripts/install-repo.sh

# Install and start docker
./scripts/install-docker.sh

# Install kubelet and start
./scripts/install-kubeadm.sh

# Load images
./scripts/load-images.sh
