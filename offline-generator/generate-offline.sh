#!/bin/sh

if [ -e /etc/redhat-release ]; then
    CREATEREPO="sudo ./create-repo.sh"
else
    CREATEREPO="./create-repo-ubuntu.sh"
fi

$CREATEREPO \
    && sudo ./save-images.sh \
    && tar cvzf k8s-offline-files.tar.gz offline-files/

echo "Done."
