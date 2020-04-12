#!/bin/bash

if [ -z "$SUDO_USER" ]; then
    echo "You muse use sudo to run this script."
    exit 1
fi

. ./config.sh

OPTS="--pod-network-cidr=$POD_NETWORK_CIDR"
if [ "$OFFLINE_INSTALL" == "yes" ]; then
    OPTS="$OPTS --ignore-preflight-errors=ImagePull"
fi

# Install master using kubeadm
echo "==> Install kubernetes master with kubeadm"
kubeadm init $OPTS $*

