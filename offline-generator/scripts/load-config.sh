#!/bin/bash

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
    . ./config.sh.default
fi
