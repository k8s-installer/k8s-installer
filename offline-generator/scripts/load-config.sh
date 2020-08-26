#!/bin/sh

# default values
KUBE_VERSIONS="1.19.0"
CONTAINER_ENGINE=docker

# load config.sh
if [ -e config.sh ]; then
    . ./config.sh
else
    echo "Warning: no config.sh exists. Use default config."
fi
