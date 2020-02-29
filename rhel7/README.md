# Download offline packages

## Prerequisites

Install docker:

    $ sudo subscription-manager repos --enable=rhel-7-server-extras-rpms
    $ sudo yum install docker yum-utils

Start docker:

    $ systemctl enable docker
    $ systemctl start docker

Setup kubernetes repo:

    $ sudo cp kubernetes.repo /etc/yum.repos.d/

## Download docker / kubeadm and dependencies

    $ ./download.sh pkglist-docker.txt
    $ ./download.sh pkglist-kubeadm.txt

## Pull all container images

    $ ./pull-images.sh
