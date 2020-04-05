#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "You must run as root."
    exit 1
fi

. ./config.sh

./setup-proxy.sh || exit 1

if [ "$OFFLINE_INSTALL" == "yes" ]; then
    ./install-common-offline.sh || exit 1
else
    ./install-common-online.sh || exit 1
fi
