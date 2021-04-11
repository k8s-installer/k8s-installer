#!/bin/sh

. ./scripts/load-config.sh

if ! type docker >/dev/null 2>&1; then
    echo "==> Install docker"
    if [ -e /etc/redhat-release ]; then
        $SUDO yum install -y docker || (echo "Error: can't install docker" && exit 1)
    else
        $SUDO apt install -y docker.io || (echo "Error: can't install docker.io" && exit 1)
    fi
fi
$SUDO systemctl enable --now docker
