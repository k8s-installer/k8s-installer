#!/bin/bash

# default values
KUBE_VERSIONS="1.19.1"
CONTAINER_ENGINE=docker

if [ $UID = 0 ]; then
    SUDO=
else
    SUDO=sudo
fi

# load config.sh
if [ -e config.sh ]; then
    . ./config.sh
else
    echo "Warning: no config.sh exists. Use default config."
fi
