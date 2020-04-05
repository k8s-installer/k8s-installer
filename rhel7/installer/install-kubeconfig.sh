#!/bin/sh

if [ "$(id -u)" -eq 0 ]; then
    echo "You must NOT run as root."
    exit 1
fi

echo "==> Setup $HOME/.kube/config"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# test cluster-info
kubectl cluster-info
