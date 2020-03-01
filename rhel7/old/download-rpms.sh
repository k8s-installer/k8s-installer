#!/bin/sh

if [ $# != 1 ]; then
    echo "usage: $0 <pkglist>"
    exit 1
fi

if [ ! -e files/rpms ]; then
    mkdir -p files/rpms
fi

PKGLIST=$1
PKGITEMS=`cat $PKGLIST | sed "s/#.*$//g" | sort -u `
echo $PKGITEMS

#sudo yum reinstall --downloadonly --downloaddir=./rpms $PKGITEMS
yumdownloader --resolve -x \*i686 --archlist=x86_64 --destdir ./files/rpms $PKGITEMS

#/bin/rm container-selinux-1*.rpm

