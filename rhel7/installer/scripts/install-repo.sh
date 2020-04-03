#!/bin/sh

. ./scripts/check-root.sh

K8S_OFFLINE_DIR=/opt/kubernetes-offline
K8S_OFFLINE_YUM_REPO=$K8S_OFFLINE_DIR/rpms

echo "==> Installing yum repo"
mkdir -p $K8S_OFFLINE_YUM_REPO
tar xvzf kubernetes-offline-repo.tar.gz -C $K8S_OFFLINE_YUM_REPO/ --strip-components=1
cp scripts/kubernetes-offline.repo /etc/yum.repos.d/
