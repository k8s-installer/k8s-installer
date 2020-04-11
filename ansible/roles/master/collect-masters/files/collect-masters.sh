#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "You must run as root."
    exit 1
fi

mkdir masters
cd masters

# Generate token and get join command
kubeadm token create --print-join-command > join.sh && exit 1

cp join.sh join-as-master.sh
sed -i  "s/^\(kubeadm join.*\)$/\1 --control-plane/" join-as-master.sh
chmod 755 *.sh

mkdir -p pki/etcd

cp \
     /etc/kubernetes/pki/ca* \
     /etc/kubernetes/pki/sa* \
     /etc/kubernetes/pki/front-proxy-ca* \
     ./pki/
cp /etc/kubernetes/pki/etcd/ca* ./pki/etcd
cp /etc/kubernetes/admin.conf .

tar cvzf ../masters.tar.gz .

# To extract:
# sudo tar xvzf masters.tar.gz -C /etc/kubernetes
