#!/bin/sh

if ! type docker >/dev/null 2>&1; then
    echo "==> Install docker"
    if [ -e /etc/redhat-release ]; then
        sudo yum install -y docker || (echo "Error: can't install docker" && exit 1)
    else
        sudo apt install docker.io || (echo "Error: can't install docker.io" && exit 1)
    fi
fi
sudo systemctl enable --now docker
