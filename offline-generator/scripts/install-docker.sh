#!/bin/sh

. ./scripts/load-config.sh

. /etc/os-release

if ! type docker >/dev/null 2>&1; then
    echo "==> Install docker"
    if [ -e /etc/redhat-release ]; then
        if [ "$VERSION_ID" = "7" ]; then
            $SUDO yum install -y docker || (echo "Error: can't install docker" && exit 1)
        else
            $SUDO yum install -y docker-ce || (echo "Error: can't install docker-ce" && exit 1)
        fi
    else
        $SUDO apt install -y docker.io || (echo "Error: can't install docker.io" && exit 1)
    fi
fi
$SUDO systemctl enable --now docker
