#!/bin/sh

if [ -e /etc/redhat-release ]; then
    CREATEREPO="sudo ./create-repo-rhel.sh"
else
    CREATEREPO="./create-repo-ubuntu.sh"
fi

./download-urls.sh || exit 1
$CREATEREPO || exit 1
sudo ./save-images.sh || exit 1

tar cvzf k8s-offline-files.tar.gz offline-files/

echo "Done."
