#!/bin/sh
ansible-playbook -i test/hosts site.yml --key-file=~/.vagrant.d/insecure_private_key
