# Download offline packages

## Setup to download docker 1.13

    $ sudo subscription-manager repos --enable=rhel-7-server-extras-rpms

    $ sudo yum install yum-utils
    
## Download docker / kubeadm and dependencies

    $ ./download.sh pkglist-docker.txt
    $ ./download.sh pkglist-kubeadm.txt
