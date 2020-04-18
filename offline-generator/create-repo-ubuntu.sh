#!/bin/sh

#. ./check-root.sh
. ./config.sh

# setup k8s repo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# seteup docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/docker.list
deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
EOF

# install tools
DOCKER_DEPS="apt-transport-https ca-certificates curl gnupg-agent software-properties-common"
sudo apt-get update && sudo apt-get install -y $DOCKER_DEPS

mkdir -p cache

PKGLIST="$DOCKER_DEPS docker-ce docker-ce-cli containerd.io kubeadm=${KUBEADM_APT_VERSION} kubelet=${KUBEADM_APT_VERSION} kubectl=${KUBEADM_APT_VERSION} firewalld"

# Get all dependencies
DEPS=$(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances --no-pre-depends $PKGLIST | grep "^\w" | sort | uniq)

# Download packages
(cd cache && apt download $PKGLIST $DEPS)

# Create repo
if [ -e debs ]; then
    /bin/rm -rf debs
fi
mkdir debs
/bin/cp cache/* debs/
/bin/rm debs/*i386.deb

cd debs
apt-ftparchive sources . > Sources && gzip -c9 Sources > Sources.gz
apt-ftparchive packages . > Packages && gzip -c9 Packages > Packages.gz
apt-ftparchive contents . > Contents-amd64 && gzip -c9 Contents-amd64 > Contents-amd64.gz
apt-ftparchive release . > Release
cd ..

# Create tarball
tar cvzf offline-files/k8s-offline-apt-repo.tar.gz debs config.sh
