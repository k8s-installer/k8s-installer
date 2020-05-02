#!/bin/bash

#. ./check-root.sh
. ./config.sh

# Package list
DOCKER_PKGS="apt-transport-https ca-certificates curl gnupg-agent software-properties-common"
DOCKER_PKGS="docker.io $DOCKER_PKGS"
#DOCKER_PKGS="docker-ce docker-ce-cli containerd.io firewalld python-cryptography $DOCKER_PKGS"

PKGS="$DOCKER_PKGS firewalld nfs-common nfs-kernel-server lvm2"

for v in $KUBE_VERSIONS; do
    PKGS="$PKGS kubeadm=${v}-00 kubelet=${v}-00 kubectl=${v}-00"
done

# setup k8s repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# seteup docker repo
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#cat <<EOF | sudo tee /etc/apt/sources.list.d/docker.list
#deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
#EOF

# install docker
sudo apt-get update && sudo apt-get install -y $DOCKER_PKGS

CACHEDIR=outputs/cache-debs
mkdir -p $CACHEDIR

# Get all dependencies
DEPS=$(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances --no-pre-depends $PKGLIST | grep "^\w" | sort | uniq)

# Download packages
(cd $CACHEDIR && apt download $PKGS $DEPS)

# Create repo
DEBDIR=outputs/debs
if [ -e $DEBDIR ]; then
    /bin/rm -rf $DEBDIR
fi
mkdir $DEBDIR
/bin/cp $CACHEDIR/* $DEBDIR
/bin/rm $DEBDIR/*i386.deb

pushd $DEBDIR || exit 1
apt-ftparchive sources . > Sources && gzip -c9 Sources > Sources.gz
apt-ftparchive packages . > Packages && gzip -c9 Packages > Packages.gz
apt-ftparchive contents . > Contents-amd64 && gzip -c9 Contents-amd64 > Contents-amd64.gz
apt-ftparchive release . > Release
popd

# Copy config.sh
cp ./config.sh outputs

# Create tarball
(cd outputs && mkdir -p offline-files && tar cvzf offline-files/k8s-offline-apt-repo.tar.gz debs config.sh)

