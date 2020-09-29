#!/bin/bash

# Setup ssh config
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N "" -q
cat ~/.ssh/id_rsa.pub >>~/.ssh/authorized_keys
ssh-keyscan -t rsa localhost >>~/.ssh/known_hosts

cd ansible

# Setup inventory files
cp ../ci/localhost inventory/
cp -r sample/group_vars inventory/

echo "container_engine: $CONTAINER_ENGINE" >> inventory/group_vars/all/main.yml

cat inventory/group_vars/all/main.yml

# Execute playbook
ansible-playbook -i inventory/localhost common.yml || (sudo journalctl -xe; exit 1)

ansible-playbook -i inventory/localhost master-first.yml || (sudo journalctl -xe; exit 1)

ansible-playbook -i inventory/localhost worker.yml networking.yml storage.yml apps.yml
