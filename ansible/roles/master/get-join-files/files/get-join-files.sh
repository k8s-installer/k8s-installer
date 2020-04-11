#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
    echo "You must run as root."
    exit 1
fi

if [ -e join-files ]; then
  /bin/rm -rf join-files
fi
mkdir join-files
cd join-files

# Generate token and get join command
kubeadm token create --print-join-command > join.sh || exit 1

sed -i  's/^\(kubeadm join.*\)$/\1 $*/' join.sh
chmod 755 *.sh

mkdir -p pki/etcd

cp \
     /etc/kubernetes/pki/ca* \
     /etc/kubernetes/pki/sa* \
     /etc/kubernetes/pki/front-proxy-ca* \
     ./pki/
cp /etc/kubernetes/pki/etcd/ca* ./pki/etcd
cp /etc/kubernetes/admin.conf .

tar cvzf ../join-files.tar.gz .

# To extract:
# sudo tar xvzf join-files.tar.gz -C /etc/kubernetes
