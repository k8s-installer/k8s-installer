#!/bin/sh

if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

# Disable SELinux
setenforce 0

# Disable swap
swapoff -a

# Start kubelet
systemctl enable --now kubelet

# sysctl
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# Do kubeadm init
kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=ImagePull
