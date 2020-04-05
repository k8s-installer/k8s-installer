#!/bin/sh

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
