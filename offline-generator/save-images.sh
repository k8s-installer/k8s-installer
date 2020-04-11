#!/bin/sh

. ./check-root.sh

if ! type docker >/dev/null 2>&1; then
    echo "==> Install docker"
    yum install -y docker || (echo "Error: can't install docker" && exit 1)
    systemctl enable --now docker
fi

if [ -e images ]; then
    /bin/rm -rf images
fi
mkdir -p images

echo "==> Pull container images"

IMGLIST=images.txt
cp $IMGLIST images

IMAGES=$(cat $IMGLIST | sed "s/#.*$//g" | sort -u)
echo $IMAGES

for i in $IMAGES; do
    echo "==> pulling $i"
    docker pull $i

    echo "==> saving $i"
    docker save $i > "images/$(basename $i).tar"
done

echo "==> Create images tarball"
tar cvzf offline-files/k8s-images.tar.gz images/
