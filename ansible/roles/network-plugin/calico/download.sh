#!/bin/sh
#VER=v3.13
#VER=v3.14
#VER=v3.15
#VER=v3.16
VER=v3.17

curl -SLO https://docs.projectcalico.org/$VER/manifests/calico.yaml
curl -SLO https://docs.projectcalico.org/$VER/manifests/calico-typha.yaml

