#!/bin/sh

doit() {
    $1 $2 $3 $4 $5 || (echo "ERROR: $1 failed"; exit 1)
}

doit ./scripts/process-yaml.sh
doit ./scripts/download-urls.sh
doit ./scripts/create-repo.sh
doit ./scripts/save-images.sh

(cd outputs && tar cvzf k8s-offline-files.tar.gz offline-files/)

echo "Done."
