# Kubernetes installer

For Japanese documentation, see [README.ja.md](./README.ja.md)

A Kubernetes installer with full offline installation support.
It uses kubeadm internally.

It supports RHEL 7, CentOS 7 and Ubuntu 18.04.

## Installation Guide

Refer [Installataion Guide](https://k8s-installer.github.io/kubernetes-guide_en.html) for detailed installation instructions.

## Requirements

* One of the following operating systems must be installed on all machines (master/worker)
    * RHEL 7
        * RedHat subscriptions must be registered.
    * CentOS 7.
    * Ubuntu 18.04.
* [Kubeadm requirement](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
    * 2 GB or more of RAM per machine (4GB or more is recommended)
    * 2 CPUs or more
    * Full network connectivity between all machines in the cluster (public or private network is fine)
    * Unique hostname, MAC address, and product_uuid for every node. 
* If you want to do an online installation
    * All machines must be able to connect to the Internet (even via proxy)
* When performing an offline installation
    * Create an offline installation file (k8s-offline-files.tar.gz) using the [offline-generator](./offline-generator/README.md) to create an offline installation file (k8s-offline-files.tar.gz) in advance.
* L4 load balancer is required for HA configuration

If you are using RHEL 7, you must enable the rhel-7-server-extras-rpms repository using the following procedure.

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## Installer

Two different installers are provided. Please refer to the respective READMEs for installation instructions.

* [script](./script/README.md): A simple script-based installer
* [ansible](./ansible/README.md): Ansible playbook-based installer

If you want to do an offline installation, use the following in combination.

* [offline-generator](./offline-generator/README.md): A generator to generate files for offline installation.

## Comparison with Kubespray

A comparison of this Ansible installer with [Kubespray](https://kubespray.io/).

* Supports full offline installation
    * This installer supports full offline installation.
* Simple.
    * Compared to Kubespray, it's simpler because it has minimal features
        * Kubespray has about 300 yaml files under role, while this installer has about 50.
        * On the other hand, we can't do anything too advanced.

## License

[MIT License](./LICENSE.txt)
