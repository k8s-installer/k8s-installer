#!/bin/sh

VER=v1.0.0

curl -L https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${VER}/deploy/static/provider/cloud/deploy.yaml > files/deploy.yaml

