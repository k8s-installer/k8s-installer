#!/bin/sh

. ./config.sh

# disable selinux
echo "==> Disable SELinux"
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config

# disable swp
echo "==> swapoff"
swapoff -a

sed -i 's/^\([^#].* swap .*\)$/#\1/' /etc/fstab

# change sysctl
echo "==> change sysctl bridge config"
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

## firewall config
if [ "$ENABLE_FIREWALLD" == "no" ]; then
    systemctl disable firewalld
    systemctl stop firewalld
else
    systemctl enable --now firewalld
    # for master node
    firewall-cmd --add-port=6443/tcp --permanent
    firewall-cmd --add-port=2379-2380/tcp --permanent
    firewall-cmd --add-port=10250-10252/tcp --permanent
    # for worker-node
    firewall-cmd --add-port=30000-32767/tcp --permanent
    firewall-cmd --reload
fi
