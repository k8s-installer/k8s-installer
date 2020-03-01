#!/bin/sh

mkdir -p files/images
mkdir -p files/rpms

cp kubernetes.repo /etc/yum.repos.d/

./download-rpms.sh pkglist-docker.txt
./download-rpms.sh pkglist-kubeadm.txt

subscription-manager repos --enable=rhel-7-server-extras-rpms

yum install files/rpms/*.rpm

systemctl enable docker
systemctl start docker

./pull-images.sh


