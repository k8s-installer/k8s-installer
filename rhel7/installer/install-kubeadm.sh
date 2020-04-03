#!/bin/sh

if [ `id -u` -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

# Install offline yum repo
K8S_OFFLINE_DIR=/opt/kubernetes-offline

echo "==> Installing yum repo"
mkdir -p $K8S_OFFLINE_DIR
tar xvzf kubernetes-offline-repo.tar.gz -C $K8S_OFFLINE_DIR
cp kubernetes-offline.repo /etc/yum.repos.d/

# Install and start docker
echo "==> Install and start docker"
yum install -y --disablerepo="*" --enablerepo=kubernetes-offline docker
systemctl enable --now docker

# Install kubeadm
. /opt/kubernetes-offline/config.sh

echo "==> Install kubeadm"
yum install -y --disablerepo="*" --enablerepo=kubernetes-offline \
    kubeadm-$K8S_VERSION \
    kubelet-$K8S_VERSION \
    kubectl-$K8S_VERSION

# Load images
echo "==> Extracting container images"
tar xvzf kubernetes-images.tar.gz

for i in images/*.tar; do
    echo "==> Loading container image: $i"
    docker load -i $i
done
