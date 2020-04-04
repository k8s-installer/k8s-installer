# Download offline packages

## Enable rhel-7-server-extras-rpms

On RHEL7:

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## Create offline repositories

Execute on some machines which has online network connection:

    $ cd generator
    $ sudo ./generate-offline.sh

Required RPM packages and container images of docker and kubernetes are downloaded.

## Install kubernetes and kubeadm

Transfer all scripts and generated k8s-offline-files.tar.gz files to target machine.

On the target machine (offline) execute:

    $ cd installer
    $ sudo ./install-kubeadm-offline.sh

Now you can use kubeadm init.

## kubeadm init

For single machine cluster:

    $ sudo ./kubeadm-init.sh
    $ ./copy-kubeconfig.sh
    $ kubectl apply -f offline-files/calico.yml
