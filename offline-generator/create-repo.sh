#!/bin/sh

. ./check-root.sh
. ./config.sh

#subscription-manager repos --enable=rhel-7-server-extras-rpms

# setup repo
if [ ! -e /etc/yum.repos.d/kubernetes.repo ]; then
    echo "==> Setup repo"
    cp kubernetes.repo /etc/yum.repos.d/
    yum check-update -y
fi

# install tools
if ! type createrepo >/dev/null 2>&1; then
    echo "==> Install createrepo"
    yum install -y createrepo
fi
if ! type repotrack >/dev/null 2>&1; then
    echo "==> Install yum-utils"
    yum install -y yum-utils
fi

# download rpms
#if [ -e /etc/yum.repos.d/kubernetes-offline.repo ]; then
#    /bin/rm /etc/yum.repos.d/kubernetes-offline.repo
#fi

mkdir -p cache

# download docker (newest version only)
RT="repotrack -a x86_64 -p cache"
echo "==> Downloading docker, kubeadm, etc"
$RT docker audit kubeadm-$K8S_VERSION libselinux-python yum-plugin-versionlock || (echo "Download error" && exit 1)

echo "==> Downloading kubectl"
$RT kubectl-$K8S_VERSION || (echo "Download error" && exit 1)

# download all versions of kubelet, because repotrack can't download
# specific version of kubelet...
echo "==> Downloading kubelet (all versions)"
$RT -n kubelet || (echo "Download error" && exit 1)

# create rpms dir
if [ -e rpms ]; then
    /bin/rm -rf rpms
fi
mkdir -p rpms
/bin/cp cache/*.rpm rpms/
/bin/rm rpms/*.i686.rpm

/bin/rm rpms/*kubelet*
/bin/cp cache/*kubelet-$K8S_VERSION* rpms/

createrepo rpms

echo "==> Create repo tarball"
tar cvzf offline-files/k8s-offline-repo.tar.gz rpms config.sh
#/bin/rm -rf rpms
