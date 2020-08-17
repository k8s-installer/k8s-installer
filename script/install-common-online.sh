#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo "You must run as root."
    exit 1
fi

. ./prepare.sh

# install & start docker
if ! type docker >/dev/null 2>&1; then
    echo "==> Install and start docker"
    yum install -y docker
fi
systemctl enable --now docker

# install kubeadm
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

echo "==> Install kubeadm, kubelet, kubectl etc"
yum install -y kubeadm kubelet kubectl yum-plugin-versionlock --disableexcludes=kubernetes
#yum versionlock add kubeadm kubelet kubectl
systemctl enable --now kubelet
