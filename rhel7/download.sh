#!/bin/sh

if [ $# != 1 ]; then
    echo "usage: $0 <pkglist>"
    exit 1
fi

PKGLIST=$1
PKGITEMS=`cat $PKGLIST | sed "s/#.*$//g" | sort -u `
echo $PKGITEMS

#sudo yum reinstall --downloadonly --downloaddir=./rpms $PKGITEMS
yumdownloader -x \*i686 --archlist=x86_64 --destdir ./rpms $PKGITEMS

#/bin/rm container-selinux-1*.rpm

