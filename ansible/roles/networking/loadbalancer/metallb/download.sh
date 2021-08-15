#!/bin/sh

VER=v0.10.2

curl -SLO https://raw.githubusercontent.com/metallb/metallb/$VER/manifests/namespace.yaml
curl -SLO https://raw.githubusercontent.com/metallb/metallb/$VER/manifests/metallb.yaml
