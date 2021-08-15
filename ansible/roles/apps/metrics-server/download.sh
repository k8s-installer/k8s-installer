#!/bin/sh

# Note: need to add '--kubelet-insecure-tls' args.
curl -L https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.0/components.yaml > files/components.yaml
