#!/bin/sh
if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

. ./config.sh

echo "==> Installing yum repo"
mkdir -p $K8S_OFFLINE_YUM_REPO
cp -r files/rpms/* $K8S_OFFLINE_YUM_REPO/
cp kubernetes-offline.repo /etc/yum.repos.d/
