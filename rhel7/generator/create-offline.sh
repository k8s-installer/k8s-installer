#!/bin/sh

. ./scripts/check-root.sh

# create offline repo
./create-repo.sh

# download kubernetes container images
./save-images.sh

# download yaml files
./get-calico.sh

