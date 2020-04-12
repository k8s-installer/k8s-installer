#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "ERROR: You must execute with sudo."
    exit 1
fi

. ./prepare.sh

OFFLINE_TARBALL=k8s-offline-files.tar.gz
REPO_TARBALL=./offline-files/k8s-offline-repo.tar.gz
IMAGES_TARBALL=./offline-files/k8s-images.tar.gz

if [ ! -e $OFFLINE_TARBALL ]; then
    echo "No $OFFLINE_TARBALL exists"
    exit 1
fi
tar xvzf $OFFLINE_TARBALL

# Install offline yum repo
K8S_OFFLINE_DIR=/opt/kubernetes-offline

echo "==> Installing offline yum repo"
mkdir -p $K8S_OFFLINE_DIR
tar xvzf $REPO_TARBALL -C $K8S_OFFLINE_DIR

cat <<EOF > /etc/yum.repos.d/kubernetes-offline.repo
[kubernetes-offline]
name=Kubernetes offline repo
baseurl=file:///opt/kubernetes-offline/rpms
enabled=1
gpgcheck=0
EOF

# Install and start docker
if ! type docker >/dev/null 2>&1; then
    echo "==> Install and start docker"
    yum install -y --disablerepo="*" --enablerepo=kubernetes-offline docker
fi
systemctl enable --now docker

# Install kubeadm
. /opt/kubernetes-offline/config.sh

echo "==> Install kubeadm"
yum install -y --disablerepo="*" --enablerepo=kubernetes-offline \
    kubeadm-$KUBEADM_VERSION \
    kubelet-$KUBEADM_VERSION \
    kubectl-$KUBEADM_VERSION
systemctl enable --now kubelet

# Load images
echo "==> Extracting container images"
tar xvzf $IMAGES_TARBALL

for i in images/*.tar; do
    echo "==> Loading container image: $i"
    docker load -i $i
done
