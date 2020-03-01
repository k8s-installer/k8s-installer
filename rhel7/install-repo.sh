#!/bin/sh
if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

K8S_OFFLINE_DIR=/opt/kubernetes-offline
K8S_OFFLINE_YUM_REPO=$K8S_OFFLINE_DIR/rpms

echo "==> Installing yum repo"
mkdir -p $K8S_OFFLINE_YUM_REPO
cp -r files/rpms/* $K8S_OFFLINE_YUM_REPO/
cp kubernetes-offline.repo /etc/yum.repos.d/
