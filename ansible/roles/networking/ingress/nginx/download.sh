#!/bin/sh

VER=v0.34.1

curl -L https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${VER}/deploy/static/provider/cloud/deploy.yaml > files/deploy.yaml

