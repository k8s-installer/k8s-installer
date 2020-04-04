#!/bin/sh

. ./check-root.sh

# create offline repo
./create-repo.sh

# download kubernetes container images
./save-images.sh

tar cvzf k8s-offline-files.tar.gz offline-files/
