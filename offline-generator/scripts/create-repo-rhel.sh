#!/bin/bash

. ./scripts/load-config.sh

. /etc/os-release

if [ "$VERSION_ID" = "7" ]; then
    if grep "Red Hat" /etc/redhat-release >/dev/null 2>&1; then
        sudo subscription-manager repos --enable=rhel-7-server-extras-rpms  # for docker
        #sudo subscription-manager repos --enable rhel-7-server-optional-rpms  # for python3-devel
    fi
fi

# packages
PKGS=$(cat pkglist/rhel/*.txt pkglist/rhel/${VERSION_ID}/*.txt | grep -v "^#" | sort | uniq)

# Add RHEL7 docker (not docker-ce)
if [ "$VERSION_ID" = "7" ]; then
    PKGS="docker $PKGS"
fi

# Docker CE
echo "==> Setup docker-ce repo"
$SUDO yum install -y yum-utils
$SUDO yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
$SUDO rpm -e podman-docker
PKGS="docker-ce $PKGS"
PKGS="containerd.io runc $PKGS"  # for containerd

for v in $KUBE_VERSIONS; do
    KUBEADM_VERSION=${v}-0

    PKGS="$PKGS kubeadm-$KUBEADM_VERSION"
    PKGS="$PKGS kubectl-$KUBEADM_VERSION"
    #PKGS="$PKGS kubelet-$KUBEADM_VERSION"
done

# setup repo
if [ ! -e /etc/yum.repos.d/kubernetes.repo ]; then
    echo "==> Setup repo"
    $SUDO cp kubernetes.repo /etc/yum.repos.d/
    $SUDO yum check-update -y
fi

# install tools
if ! type createrepo >/dev/null 2>&1; then
    echo "==> Install createrepo"
    $SUDO yum install -y createrepo || exit 1
fi
if ! type repotrack >/dev/null 2>&1; then
    echo "==> Install yum-utils"
    $SUDO yum install -y yum-utils || exit 1
fi

CACHEDIR=outputs/cache-rpms
mkdir -p $CACHEDIR

cp ./config.sh outputs

if [ "$VERSION_ID" = "7" ]; then
    RT="$SUDO repotrack -a x86_64 -p $CACHEDIR"
else
    RT="$SUDO dnf download --resolve --alldeps --downloaddir $CACHEDIR"
fi

YD="$SUDO yumdownloader --destdir=$CACHEDIR -y"

echo "==> Downloading: " $PKGS
$RT $PKGS || (echo "Download error" && exit 1)

# download kubelet with yumdownloader, because repotrack can't download specific version of kubelet...
for v in $KUBE_VERSIONS; do
    KUBEADM_VERSION=${v}-0

    echo "==> Downloading kubelet $KUBEADM_VERSION"
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

$SUDO createrepo $RPMDIR || exit 1

echo "==> Create repo tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/offline-rpm-repo.tar.gz rpms config.sh)

echo "create-repo done."
