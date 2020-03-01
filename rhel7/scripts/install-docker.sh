#!/bin/sh

. ./scripts/check-root.sh

# install & start docker
echo "==> Install and start docker"
yum install -y --disablerepo="*" --enablerepo=kubernetes-offline docker
systemctl enable docker
systemctl start docker

