#!/bin/sh

# setup repo
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo cp kubernetes.repo /etc/yum.repos.d/

sudo yum check-update -y

# download rpms
mkdir -p files/rpms
#sudo ./download-rpms.sh pkglist-docker.txt
#sudo ./download-rpms.sh pkglist-kubeadm.txt
repotrack -a x86_64 -p files/rpms docker kubeadm kubectl kubelet

# install & start docker
sudo yum install -y files/rpms/*.rpm
sudo systemctl enable docker
sudo systemctl start docker

# download kubernetes container images
sudo ./pull-images.sh


