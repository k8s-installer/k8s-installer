#!/bin/sh
#vagrant up

vagrant ssh ubuntu -c "(cd offline-generator && ./scripts/create-repo-ubuntu.sh)"
vagrant ssh centos -c "(cd offline-generator && ./generate-offline.sh)"

#vagrant destroy -f

