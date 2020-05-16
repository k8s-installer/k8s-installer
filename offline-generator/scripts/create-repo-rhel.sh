#!/bin/sh

. ./config.sh

. /etc/os-release

# packages
PKGLIST="pkglist/rhel/*.txt"
if [ "$VERSION_ID" = "7" ]; then
    PKGLIST="$PKGLIST pkglist/rhel/7/*.txt"
    
    if grep "Red Hat" /etc/redhat-release >/dev/null 2>&1; then
        sudo subscription-manager repos --enable=rhel-7-server-extras-rpms  # for docker
        #sudo subscription-manager repos --enable rhel-7-server-optional-rpms  # for python3-devel
    fi
fi
PKGS=$(cat $PKGLIST | grep -v "^#" | sort | uniq)

if [ "$CONTAINER_ENGINE" = "docker" ]; then
    PKGS="docker $PKGS"
else
    PKGS="runc $PKGS"  # for containerd
fi

for v in $KUBE_VERSIONS; do
    KUBEADM_VERSION=${v}-0

    PKGS="$PKGS kubeadm-$KUBEADM_VERSION"
    PKGS="$PKGS kubectl-$KUBEADM_VERSION"
    #PKGS="$PKGS kubelet-$KUBEADM_VERSION"
done

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

CACHEDIR=outputs/cache-rpms
mkdir -p $CACHEDIR

cp ./config.sh outputs

if [ "$VERSION_ID" = "8" ]; then
    RT="sudo dnf download --resolve --alldeps --downloaddir $CACHEDIR"
else
    RT="sudo repotrack -a x86_64 -p $CACHEDIR"
fi

YD="sudo yumdownloader --destdir=$CACHEDIR -y"

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

#/bin/rm rpms/*kubelet*
#/bin/cp cache/*kubelet-$KUBEADM_VERSION* rpms/

sudo createrepo $RPMDIR || exit 1

echo "==> Create repo tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/offline-rpm-repo.tar.gz rpms config.sh)
#/bin/rm -rf rpms

echo "create-repo done."
