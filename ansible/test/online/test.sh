#!/bin/sh
ansible-playbook -i test/online/hosts site.yml # --key-file=~/.vagrant.d/insecure_private_key
