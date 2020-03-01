#!/bin/sh

if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

. ./config.sh

# setup repo
echo "==> Setup repo"
subscription-manager repos --enable=rhel-7-server-extras-rpms
cp kubernetes.repo /etc/yum.repos.d/

yum check-update -y

# install tools
echo "==> Install yum tools"
yum install -y yum-utils createrepo

# download rpms
echo "==> Downloading rpms"
mkdir -p files/rpms
if [ -e /etc/yum.repos.d/kubernetes-offline.repo ]; then
    /bin/rm /etc/yum.repos.d/kubernetes-offline.repo
fi

# download docker (newest version only)
repotrack -a x86_64 -p files/rpms docker audit \
          kubeadm-$K8S_VERSION kubectl-$K8S_VERSION kubelet-$K8S_VERSION

/bin/rm files/rpms/*.i686.rpm
createrepo files/rpms

