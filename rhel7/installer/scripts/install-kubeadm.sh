#!/bin/sh

. ./scripts/check-root.sh

. /opt/kubernetes-offline/config.sh

yum install -y --disablerepo="*" --enablerepo=kubernetes-offline \
    kubeadm-$K8S_VERSION \
    kubelet-$K8S_VERSION \
    kubectl-$K8S_VERSION
