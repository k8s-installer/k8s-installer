#!/bin/bash

. ./config.sh

expand_image_repo() {
    local repo="$1"

    if [[ "$repo" =~ ^[a-zA-Z0-9]+: ]]; then
        repo="docker.io/library/$repo"
    elif [[ "$repo" =~ ^[a-zA-Z0-9]+\/ ]]; then
        repo="docker.io/$repo"
    fi
    echo "$repo"
}

image_pull() {
    image="$1"

    if [ "$CONTAINER_ENGINE" = "docker" ]; then
        sudo docker pull $image || exit 1
    else
        sudo ctr -n k8s.io images pull $image || exit 1
    fi
}

image_save() {
    image="$1"
    out="$2"

    if [ "$CONTAINER_ENGINE" = "docker" ]; then
        sudo docker save $image > "$out" || exit 1
    else
        sudo ctr -n k8s.io images export $out $image || exit 1
    fi
}

if [ "$CONTAINER_ENGINE" = "docker" ]; then
    ./scripts/install-docker.sh || exit 1
else
    ./scripts/install-containerd.sh || exit 1
fi

IMAGEDIR=outputs/images
if [ -e $IMAGEDIR ]; then
    /bin/rm -rf $IMAGEDIR
fi
mkdir -p $IMAGEDIR

echo "==> Pull container images"

cat imagelists/*.txt outputs/*-images.txt | sed "s/#.*$//g" | sort -u > $IMAGEDIR/images.txt
cat $IMAGEDIR/images.txt

IMAGES=$(cat $IMAGEDIR/images.txt)

for i in $IMAGES; do
    i=$(expand_image_repo $i)
    f="$(echo $i | sed 's/\//_/g').tar"

    echo "==> pulling $i"
    image_pull $i

    echo "==> saving $i to $IMAGEDIR/$f"
    image_save $i "$IMAGEDIR/$f" || exit 1
done

echo "==> Create images tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/k8s-images.tar.gz images/)
