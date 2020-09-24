#!/bin/bash

PJDIR=$PWD

echo "Starting docker"
docker run -d -it -v $HOME:$HOME $BASE /bin/bash

DOCKER_CONTAINER_ID=$(docker ps | grep centos | awk '{print $1}')
echo "Container id is $DOCKER_CONTAINER_ID please wait while updates applied"

docker exec -it $DOCKER_CONTAINER_ID /bin/bash -xec "cd $PJDIR/offline-generator && ./generate-offline.sh"

echo "Stopping container"
docker stop $DOCKER_CONTAINER_ID
docker rm -v $DOCKER_CONTAINER_ID
