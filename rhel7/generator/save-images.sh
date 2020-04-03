#!/bin/sh

. ./check-root.sh

if [ -e images ]; then
    /bin/rm -rf images
fi
mkdir -p images

echo "==> Pull container images"

IMGLIST=images.txt
cp $IMGLIST images

IMAGES=`cat $IMGLIST | sed "s/#.*$//g" | sort -u `
echo $IMAGES

for i in $IMAGES; do
    echo "==> pulling $i"
    docker pull $i

    echo "==> saving $i"
    docker save $i > images/`basename $i`.tar
done

echo "==> Create images tarball"
tar cvzf kubernetes-images.tar.gz images/
