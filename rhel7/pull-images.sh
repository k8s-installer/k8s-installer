#!/bin/sh

if [ ! -e files/images ]; then
    mkdir -p files/images
fi

echo "==> Pull container images"

IMGLIST=images.txt
IMAGES=`cat $IMGLIST | sed "s/#.*$//g" | sort -u `
echo $IMAGES

for i in $IMAGES; do
    echo "==> pulling $i"
    docker pull $i

    echo "==> saving $i"
    docker save $i > files/images/`basename $i`.tar

    echo "==> compressing $i"
    gzip files/images/`basename $i`.tar
done
