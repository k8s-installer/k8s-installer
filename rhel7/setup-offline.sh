#!/bin/sh

if [ `id -u` -ne 0 ]; then
    echo "Error: You must run this with sudo."
    exit 1
fi

# setup repo
subscription-manager repos --enable=rhel-7-server-extras-rpms
cp kubernetes.repo /etc/yum.repos.d/

yum check-update -y

# download docker stuff
./download-rpms.sh pkglist-docker.txt

# install & start docker
yum install -y files/rpms/*.rpm
systemctl enable docker
systemctl start docker

# download kubernetes stuff
./download-rpms.sh pkglist-kubeadm.txt

# download kubernetes container images
./pull-images.sh


