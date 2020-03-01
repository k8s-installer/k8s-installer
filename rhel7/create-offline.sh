#!/bin/sh

# create offline repo
sudo ./create-repo.sh

# install offline repo
sudo ./install-repo.sh

# install & start docker
sudo ./install-docker.sh

# download kubernetes container images
sudo ./pull-images.sh

