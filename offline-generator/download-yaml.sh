#!/bin/sh
curl -L https://docs.projectcalico.org/v3.13/manifests/calico.yaml > offline-files/calico.yaml
curl -L https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml > offline-files/metrics-server.yaml
