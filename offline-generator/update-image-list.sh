#!/bin/sh

. ./config.sh

if ! type kubeadm >/dev/null 2>&1; then
    sudo ./install-kubeadm.sh
fi

kubeadm config images list --kubernetes-version $KUBE_VERSION > images.txt

grep "^ *image: " offline-files/calico.yaml | sed 's/^ *image: *//' | sort | uniq >> images.txt

echo "registry:2.7.1" >> images.txt

