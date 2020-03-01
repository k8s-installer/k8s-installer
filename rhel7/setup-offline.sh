#!/bin/sh

# setup repo
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo cp kubernetes.repo /etc/yum.repos.d/

sudo yum check-update -y

# download docker stuff
./download-rpms.sh pkglist-docker.txt

# install & start docker
sudo yum install -y files/rpms/*.rpm
sudo systemctl enable docker
sudo systemctl start docker

# download kubernetes stuff
sudo ./download-rpms.sh pkglist-kubeadm.txt

# download kubernetes container images
sudo ./pull-images.sh


