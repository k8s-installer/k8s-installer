#!/bin/sh

if ! type docker >/dev/null 2>&1; then
    echo "==> Install docker"
    if [ -e /etc/redhat-release ]; then
        sudo yum install -y docker || (echo "Error: can't install docker" && exit 1)
    else
        sudo apt install docker.io || (echo "Error: can't install docker.io" && exit 1)
    fi
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
    sudo docker pull $i

    f="$(echo $i | sed 's/\//__/g').tar"
    echo "==> saving $i"
    sudo docker save $i > "$IMAGEDIR/$f"
done

echo "==> Create images tarball"
mkdir -p outputs/offline-files
(cd outputs && tar cvzf offline-files/k8s-images.tar.gz images/)
