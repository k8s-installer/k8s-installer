#!/bin/sh

. ./check-root.sh

./create-repo.sh \
    && ./save-images.sh \
    && tar cvzf k8s-offline-files.tar.gz offline-files/

echo "Done."
