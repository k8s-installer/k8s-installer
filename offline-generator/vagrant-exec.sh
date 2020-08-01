#!/bin/sh
#vagrant up

vagrant ssh ubuntu -c "(cd k8s-installer/offline-generator && ./scripts/create-repo-ubuntu.sh)"
vagrant ssh centos -c "(cd k8s-installer/offline-generator && ./generate-offline.sh)"

#vagrant destroy -f

