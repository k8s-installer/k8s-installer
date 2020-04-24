#!/bin/sh

if [ -e /etc/redhat-release ]; then
    CREATEREPO="./scripts/create-repo-rhel.sh"
else
    CREATEREPO="./scripts/create-repo-ubuntu.sh"
fi

doit() {
    $1 $2 $3 $4 $5 || (echo "ERROR: $1 failed"; exit 1)
}

doit ./scripts/process-yaml.sh
doit ./scripts/download-urls.sh
doit $CREATEREPO
doit ./scripts/save-images.sh

(cd outputs && tar cvzf k8s-offline-files.tar.gz offline-files/)

echo "Done."
