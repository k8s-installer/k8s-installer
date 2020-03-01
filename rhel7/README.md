# Download offline packages

## Create offline repositories

Execute on some machines which has online network connection:

    $ sudo ./create-offline.sh

Required RPM packages and container images of docker and kubernetes are downloaded.

Transfer all scripts and generated *.tar.gz files to target machine.

## Install kubernetes and kubeadm

On the target machine (offline) execute:

    $ sudo ./install.sh

Now you can use kubeadm init.




