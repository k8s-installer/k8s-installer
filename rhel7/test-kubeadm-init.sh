#!/bin/sh

# Disable SELinux
sudo setenforce 0

# Disable swap
sudo swapoff -a

# Install kubelet and start
#sudo yum install -y files/rpms/*.rpm
sudo systemctl enable --now kubelet

# sysctl
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

# Do kubeadm init
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

# Copy kubelet config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
