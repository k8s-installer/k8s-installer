#!/bin/sh

. ./config.sh

if [ -e ./offline-files/calico.yaml ]; then
    YAML=./offline-files/calico.yaml
else
    https_proxy=$PROXY_URL curl -SLO https://docs.projectcalico.org/v3.13/manifests/calico.yaml
    YAML=calico.yaml
fi

echo "==> Install calico network addon"
kubectl apply -f $YAML
