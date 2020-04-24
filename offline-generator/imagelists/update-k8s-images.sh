#!/bin/sh

# コンテナイメージリスト (images.txt) を最新化する

. ../config.sh

parse_yaml() {
    grep "^ *image: " $1 | sed 's/^ *image: *//' | sort | uniq >> images.txt
}


if ! type kubeadm >/dev/null 2>&1; then
    (cd .. && sudo ./install-kubeadm.sh)
fi

# Get kubernetes container image list
for v in $KUBE_VERSIONS; do
    kubeadm config images list --kubernetes-version $v > k8s-images.txt
done
