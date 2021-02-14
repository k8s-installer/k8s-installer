#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "You must run as root."
    exit 1
fi

TMPDIR=$(mktemp -d)
cd "$TMPDIR" || exit 1

# Upload certificates and get certificate key
kubeadm init phase --config /etc/kubernetes/kubeadm-config.yml upload-certs --upload-certs | tail -1 > certificateKey || exit 1

# Generate token and get join command
kubeadm token create --print-join-command --kubeconfig=/etc/kubernetes/admin.conf > join.sh || exit 1

sed -i  's/^\(kubeadm join.*\)$/\1 $*/' join.sh
chmod 755 *.sh

#mkdir -p pki/etcd

#cp \
#     /etc/kubernetes/pki/ca* \
#     /etc/kubernetes/pki/sa* \
#     /etc/kubernetes/pki/front-proxy-ca* \
#     ./pki/
#cp /etc/kubernetes/pki/etcd/ca* ./pki/etcd
#cp /etc/kubernetes/admin.conf .

#tar cvzf /tmp/join-files.tar.gz .
cp join.sh certificateKey /tmp/

cd /
/bin/rm -rf "$TMPDIR"

# To extract:
# sudo tar xvzf join-files.tar.gz -C /etc/kubernetes
