#!/bin/sh

. ./config.sh

. /etc/os-release

# dependencies
PY2DEPS="libselinux-python python-virtualenv python2-cryptography"
PY3DEPS="python3" # python3-devel gcc openssl-devel"
NFS_DEPS="rpcbind nfs-utils"

DEPS="audit yum-plugin-versionlock firewalld gnupg2 lvm2"
if [ "$VERSION_ID" = "7" ]; then
    DEPS="docker $DEPS $PY2DEPS $PY3DEPS $NFS_DEPS"
else
    DEPS="runc $DEPS $PY3DEPS $NFS_DEPS"
fi

# rhel7
if type subscription-manager >/dev/null 2>&1; then
    sudo subscription-manager repos --enable=rhel-7-server-extras-rpms  # for docker
    #sudo subscription-manager repos --enable rhel-7-server-optional-rpms  # for python3-devel
fi

# setup repo
if [ ! -e /etc/yum.repos.d/kubernetes.repo ]; then
    echo "==> Setup repo"
    sudo cp kubernetes.repo /etc/yum.repos.d/
    sudo yum check-update -y
fi

# install tools
if ! type createrepo >/dev/null 2>&1; then
    echo "==> Install createrepo"
    sudo yum install -y createrepo || exit 1
fi
if ! type repotrack >/dev/null 2>&1; then
    echo "==> Install yum-utils"
    sudo yum install -y yum-utils || exit 1
fi

# download rpms
#if [ -e /etc/yum.repos.d/kubernetes-offline.repo ]; then
#    /bin/rm /etc/yum.repos.d/kubernetes-offline.repo
#fi

CACHEDIR=outputs/cache-rpms
mkdir -p $CACHEDIR

cp ./config.sh outputs

if [ "$VERSION_ID" = "8" ]; then
    RT="sudo dnf download --resolve --alldeps --downloaddir $CACHEDIR"
else
    RT="sudo repotrack -a x86_64 -p $CACHEDIR"
fi

YD="sudo yumdownloader --destdir=$CACHEDIR -y"

echo "==> Downloading $DEPS"
$RT $DEPS || (echo "Download error" && exit 1)

for v in $KUBE_VERSIONS; do
    KUBEADM_VERSION=${v}-0

    echo "==> Downloading kubeadm $KUBEADM_VERSION"
    $RT kubeadm-$KUBEADM_VERSION || (echo "Download error" && exit 1)

    echo "==> Downloading kubectl $KUBEADM_VERSION"
    $RT kubectl-$KUBEADM_VERSION || (echo "Download error" && exit 1)

    echo "==> Downloading kubelet $KUBEADM_VERSION"
    #$RT kubelet-$KUBEADM_VERSION || (echo "Download error" && exit 1)

    # download with yumdownloader, because repotrack can't download specific version of kubelet...
    $YD kubelet-$KUBEADM_VERSION || (echo "Download error" && exit 1)
done

# create rpms dir
RPMDIR=outputs/rpms
if [ -e $RPMDIR ]; then
    /bin/rm -rf $RPMDIR || exit 1
fi
mkdir -p $RPMDIR
/bin/cp $CACHEDIR/*.rpm $RPMDIR/
/bin/rm $RPMDIR/*.i686.rpm

#/bin/rm rpms/*kubelet*
#/bin/cp cache/*kubelet-$KUBEADM_VERSION* rpms/

sudo createrepo $RPMDIR || exit 1

echo "==> Create repo tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/k8s-offline-repo.tar.gz rpms config.sh)
#/bin/rm -rf rpms

echo "create-repo done."
