#!/bin/sh

K8S_OFFLINE_DIR=/opt/kubernetes-offline
K8S_OFFLINE_YUM_REPO=$K8S_OFFLINE_DIR/rpms

# setup repo
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo cp kubernetes.repo /etc/yum.repos.d/

sudo yum check-update -y

# install tools
sudo yum install -y yum-utils createrepo

# download rpms
echo "==> Downloading rpms"
sudo mkdir -p $K8S_OFFLINE_YUM_REPO
sudo repotrack -a x86_64 -p $K8S_OFFLINE_YUM_REPO docker kubeadm kubectl kubelet
sudo /bin/rm $K8S_OFFLINE_YUM_REPO/*.i686.rpm
sudo createrepo $K8S_OFFLINE_YUM_REPO

# install & start docker
echo "==> Install and start docker"
sudo cp kubernetes-offline.repo /etc/yum.repos.d/
sudo yum install -y --disablerepo=\\* --enablerepo=kubernetes-offline docker
sudo systemctl enable docker
sudo systemctl start docker

# download kubernetes container images
echo "==> Pull container images"
sudo ./pull-images.sh

