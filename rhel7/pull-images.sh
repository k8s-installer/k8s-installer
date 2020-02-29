#!/bin/sh

IMGLIST=images.txt
IMAGES=`cat $IMGLIST | sed "s/#.*$//g" | sort -u `
echo $IMAGES

for i in $IMAGES; do
    echo pulling $i
    docker pull $i

    echo saving $i
    docker save $i > images/`basename $i`.tar
done
