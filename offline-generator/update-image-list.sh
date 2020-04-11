#!/bin/sh

# コンテナイメージリスト (images.txt) を最新化する

. ./config.sh

if ! type kubeadm >/dev/null 2>&1; then
    sudo ./install-kubeadm.sh
fi

# Get kubernetes container image list
kubeadm config images list --kubernetes-version $KUBE_VERSION > images.txt

# Get calico image list
grep "^ *image: " offline-files/calico.yaml | sed 's/^ *image: *//' | sort | uniq >> images.txt

# Additional list
cat <<EOF >> images.txt
registry:2.7.1
EOF
