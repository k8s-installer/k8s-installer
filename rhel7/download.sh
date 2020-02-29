#!/bin/sh
PKGLIST=pkglist.txt
PKGITEMS=`cat $PKGLIST | sed "s/#.*$//g" | sort -u `
echo $PKGITEMS

#sudo yum reinstall --downloadonly --downloaddir=. $PKGITEMS
yumdownloader -x \*i686 --archlist=x86_64 $PKGITEMS

/bin/rm container-selinux-1*.rpm
