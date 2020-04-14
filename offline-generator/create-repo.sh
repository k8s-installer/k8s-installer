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
    yum install -y createrepo || exit 1
fi
if ! type repotrack >/dev/null 2>&1; then
    echo "==> Install yum-utils"
    yum install -y yum-utils || exit 1
fi

# download rpms
#if [ -e /etc/yum.repos.d/kubernetes-offline.repo ]; then
#    /bin/rm /etc/yum.repos.d/kubernetes-offline.repo
#fi

mkdir -p cache

# download docker (newest version only)
RT="repotrack -a x86_64 -p cache"
YD="yumdownloader --destdir=cache -y"

echo "==> Downloading docker, kubeadm, etc"
$RT docker audit kubeadm-$KUBEADM_VERSION libselinux-python yum-plugin-versionlock firewalld python3 || (echo "Download error" && exit 1)

echo "==> Downloading kubectl"
$RT kubectl-$KUBEADM_VERSION || (echo "Download error" && exit 1)

echo "==> Downloading kubelet"
#$RT -n kubelet || (echo "Download error" && exit 1)  # download all versions with '-n'
$RT kubelet-$KUBEADM_VERSION || (echo "Download error" && exit 1)

# download with yumdownloader, because repotrack can't download specific version of kubelet...
$YD kubelet-$KUBEADM_VERSION || (echo "Download error" && exit 1)

# create rpms dir
if [ -e rpms ]; then
    /bin/rm -rf rpms || exit 1
fi
mkdir -p rpms
/bin/cp cache/*.rpm rpms/
/bin/rm rpms/*.i686.rpm

#/bin/rm rpms/*kubelet*
#/bin/cp cache/*kubelet-$KUBEADM_VERSION* rpms/

createrepo rpms || exit 1

echo "==> Create repo tarball"
tar cvzf offline-files/k8s-offline-repo.tar.gz rpms config.sh
#/bin/rm -rf rpms
