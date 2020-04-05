# Ansible playbook to install kubernetes cluster with kubeadm

## Vagrant Configuration

Startup following VMs:

* lb: 10.240.0.40
    * load balander (haproxy) and NAT router
* master-0: 10.240.0.10
* master-1: 10.240.0.11
* master-2: 10.240.0.12
* worker-0: 10.240.0.20
* worker-1: 10.240.0.21

Note: All master/worker nodes has default gateway to lb (not NAT interface).
Because kubeadm detects each server api address from default route, and incorrectly use
ip address of NAT interface.

## Startup single master kubernetes cluster with kubeadm

Install and setup docker, kubelet, kubectl and kubeadm with:

    $ ansible-playbook -i hosts site.yml

On master-0:

    # For single node cluster
    $ sudo kubeadm init --pod-network-cidr=192.168.0.0/16

    # For HA cluster
    $ sudo kubeadm init --config=kubeadm-config.yml

Take memo with 'kubeadm join..." command line.

Copy kube config file:

    $ mkdir -p $HOME/.kube
    $ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    $ sudo chown $(id -u):$(id -g) $HOME/.kube/config

Install calico network plugin:

    $ kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

On each workers:

    $ sudo kubeadm join...

## Startup HA cluster with kubeadm

On master-0:

    $ sudo kubeadm init --config kubeadm-config.yml

Retrieve admin.conf and certificates/keys using `collect-masters.sh` on master-0.
Transfer masters.tar.gz to master-1 and master-2 and execute followings on each master-1/2:

    $ sudo tar xvzf masters.tar.gz --strip-components=1 -C /etc/kubernetes

On master-1 and master-2, execute `kubeadm join ...` with --apiserver-advertise-address option with
each IP address of the machine.
