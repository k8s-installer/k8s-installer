#!/bin/sh

if [ -e /etc/redhat-release ]; then
    CREATEREPO="./scripts/create-repo-rhel.sh"
else
    CREATEREPO="./scripts/create-repo-ubuntu.sh"
fi

$CREATEREPO
