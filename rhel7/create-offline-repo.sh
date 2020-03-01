#!/bin/sh

# setup repo
echo "==> Setup repo"
sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
sudo cp kubernetes.repo /etc/yum.repos.d/

sudo yum check-update -y

# install tools
echo "==> Install yum tools"
sudo yum install -y yum-utils createrepo

# download rpms
echo "==> Downloading rpms"
sudo mkdir -p files/rpms
sudo repotrack -a x86_64 -p files/rpms docker kubeadm kubectl kubelet audit
sudo /bin/rm files/rpms/*.i686.rpm
sudo createrepo files/rpms
