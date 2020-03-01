#!/bin/sh

K8S_OFFLINE_DIR=/opt/kubernetes-offline
K8S_OFFLINE_YUM_REPO=$K8S_OFFLINE_DIR/rpms

# create offline repo
./create-offline-repo.sh

sudo mkdir -p $K8S_OFFLINE_YUM_REPO
sudo cp -r files/rpms/* $K8S_OFFLINE_YUM_REPO/

# install & start docker
echo "==> Install and start docker"
sudo cp kubernetes-offline.repo /etc/yum.repos.d/
sudo yum install -y --disablerepo="*" --enablerepo=kubernetes-offline docker
sudo systemctl enable docker
sudo systemctl start docker

# download kubernetes container images
echo "==> Pull container images"
sudo ./pull-images.sh

