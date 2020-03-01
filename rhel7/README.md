# Download offline packages

## Enable rhel-7-server-extras-rpms

On RHEL7:

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## Create offline repositories

Execute on some machines which has online network connection:

    $ sudo ./create-offline.sh

Required RPM packages and container images of docker and kubernetes are downloaded.

## Install kubernetes and kubeadm

Transfer all scripts and generated *.tar.gz, *.yaml files to target machine.

On the target machine (offline) execute:

    $ sudo ./install.sh

Now you can use kubeadm init.

## kubeadm init

For single machine cluster:

    $ sudo ./kubeadm-init.sh
    $ ./copy-kubelet-config.sh
    $ kubectl apply -f calico.yml
