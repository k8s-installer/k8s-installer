#!/bin/sh

mkdir masters
cd masters

# Generate token and get join command
kubeadm token create --print-join-command > join.sh

cp join.sh join-as-master.sh
sed -i  "s/^\(kubeadm join.*\)$/\1 --control-plane/" join-as-master.sh
chmod 755 *.sh

mkdir -p pki/etcd

sudo cp \
     /etc/kubernetes/pki/ca* \
     /etc/kubernetes/pki/sa* \
     /etc/kubernetes/pki/front-proxy-ca* \
     ./pki/
sudo cp /etc/kubernetes/pki/etcd/ca* ./pki/etcd
sudo cp /etc/kubernetes/admin.conf .

sudo tar cvzf ../masters.tar.gz .

# To extract:
# sudo tar xvzf masters.tar.gz -C /etc/kubernetes
