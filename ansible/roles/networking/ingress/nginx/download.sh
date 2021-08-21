#!/bin/sh

#VER=v0.48.1
VER=v1.0.0-beta.3

curl -L https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-${VER}/deploy/static/provider/cloud/deploy.yaml > files/deploy.yaml

