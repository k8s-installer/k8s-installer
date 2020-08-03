#!/bin/bash

# Execute offline test

function generate_offline() {
    pushd ../offline-generator || exit 1
    vagrant destroy -f || exit 1
    vagrant up || exit 1

    echo "Removing outputs dir"
    /bin/rm -rf ./outputs

    echo "Execute generate-offline"
    ./vagrant-exec.sh || exit 1

    vagrant destroy -f || exit 1
    popd
}

function ansible_offline() {
    echo "Extract offline files to ansible dir"
    tar xvzf ../offline-generator/outputs/k8s-offline-files.tar.gz -C ../ansible/ || exit 1

    pushd ../ansible || exit 1

    (cd test/offline && vagrant destroy -f && vagrant up) || exit 1

    ./test/offline/prepare.sh || exit 1

    echo "Execute ansible installer"
    ansible-playbook -i test/offline/hosts site.yml || exit 1

    popd
}

if [ ! -e ../offline-generator/outputs/k8s-offline-files.tar.gz ]; then
    generate_offline
fi

ansible_offline
