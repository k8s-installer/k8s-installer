#!/bin/sh

. ./config.sh

if [ "$CONTAINER_ENGINE" = "containerd" ]; then
    PULL="sudo ctr images pull"
    EXPORT="sudo images export"
    ./scripts/install-containerd.sh || exit 1
else
    PULL="sudo docker pull"
    EXPORT="sudo docker save"
    ./scripts/install-docker.sh || exit 1
fi

sudo systemctl enable --now docker

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
    echo "==> pulling $i"
    $PULL $i

    f="$(echo $i | sed 's/\//__/g').tar"
    echo "==> saving $i"
    $EXPORT $i > "$IMAGEDIR/$f"
done

echo "==> Create images tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/k8s-images.tar.gz images/)
