#!/bin/sh

# install kubeadm, needed to pull image of k8s images

. ./check-root.sh
#. ./config.sh

# setup repo
if [ ! -e /etc/yum.repos.d/kubernetes.repo ]; then
    echo "==> Setup repo"
    cp kubernetes.repo /etc/yum.repos.d/
    yum check-update -y
fi

# install docker
if ! type docker >/dev/null 2>&1; then
    yum install -y docker
fi
systemctl enable --now docker

# install kubeadm
#yum install -y kubeadm-$KUBEADM_VERSION
yum install -y kubeadm

