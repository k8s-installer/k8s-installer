#!/bin/sh

. ./scripts/check-root.sh

# create offline repo
./scripts/create-repo.sh

# install offline repo
./scripts/install-repo.sh

# install & start docker
./scripts/install-docker.sh

# download kubernetes container images
./scripts/save-images.sh

# download yaml files
./scripts/get-calico.sh
