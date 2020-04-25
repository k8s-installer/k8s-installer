#!/bin/sh
ansible-playbook -i test/offline/hosts site.yml # --key-file=~/.vagrant.d/insecure_private_key
