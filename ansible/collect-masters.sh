#!/bin/sh
mkdir -p masters/pki/etcd

sudo cp \
     /etc/kubernetes/pki/ca* \
     /etc/kubernetes/pki/sa* \
     /etc/kubernetes/pki/front-proxy-ca* \
     masters/pki
sudo cp /etc/kubernetes/pki/etcd/ca* masters/pki/etcd
sudo cp /etc/kubernetes/admin.conf masters

sudo tar cvzf masters.tar.gz masters

# To extract:
# sudo tar xvzf masters.tar.gz --strip-components=1 -C /etc/kubernetes

