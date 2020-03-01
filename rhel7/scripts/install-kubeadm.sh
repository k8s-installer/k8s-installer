#!/bin/sh

. ./scripts/check-root.sh

yum install -y --disablerepo="*" --enablerepo=kubernetes-offline kubeadm kubelet kubectl
