#!/bin/sh

# install kubeadm, needed to pull image of k8s images

. ./check-root.sh
. ./config.sh

# setup repo
if [ ! -e /etc/yum.repos.d/kubernetes.repo ]; then
    echo "==> Setup repo"
    cp kubernetes.repo /etc/yum.repos.d/
    yum check-update -y
fi

# install kubeadm (and docker)
yum install -y docker kubeadm-$K8S_VERSION
systemctl enable --now docker
