#!/bin/bash

if [ -z "$SUDO_USER" ]; then
    echo "You muse use sudo to run this script."
    exit 1
fi

. ./config.sh

if [ -z "$LOAD_BALANCER_DNS" ]; then
    echo "You must set LOAD_BALANCER_DNS in config.sh"
    exit 1
fi

POD_NETWORK_CIDR=${POD_NETWORK_CIDR:-192.168.0.0/16}
LOAD_BALANCER_PORT=${LOAD_BALANCER_PORT:-6443}

cat <<EOF > kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: stable
apiServer:
  certSANs:
    - "$LOAD_BALANCER_DNS"
controlPlaneEndpoint: "$LOAD_BALANCER_DNS:$LOAD_BALANCER_PORT"
networking:
  podSubnet: "$POD_NETWORK_CIDR"
EOF

OPTS=""
if [ "$OFFLINE_INSTALL" == "yes" ]; then
    OPTS="$OPTS --ignore-preflight-errors=ImagePull"
fi

# Install master using kubeadm
echo "==> Install kubernetes master with kubeadm"
kubeadm init --config kubeadm-config.yaml $OPTS $*
