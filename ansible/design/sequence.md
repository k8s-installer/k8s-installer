# Install sequence

Install sequence of each playbooks and roles.

## [common playbook](../common.yml)

Common sequence for all nodes.

* [installer-defaults](../roles/installer-defaults) : Set default values of variables.
* [preflight](../roles/preflight) : Do preflight check
* [offline/prepare](../roles/offline/prepare) : Execute file transfer and unarchive for offline install.
* [setproxy](../roles/setproxy) : Configure proxy (yum/docker)
* [firewall](../roles/firewall) : Configure firewalld
* [preinstall](../roles/preinstall) : Pre install process
* container-engine
    * [docker](../roles/container-engine/docker) : Install docker
    * [containerd](../roles/container-engine/containerd) : Install containerd (RHEL/CentOS 8)
* [offline/load-images](../roles/offline/load-images) : Import container images for offline install
* [k8s-packages](../roles/k8s-packages): Install kubeadm / kubelet.
    * Add kubernetes yum/apt repository.
    * Install kubeadm, kubelet, kubectl and lock versions
    * Add --node-ip option to kubelet
    * Start kubelet

## [master-first playbook](../master-first.yml)

Install primary master node.

* [master/certs/ca](../roles/master/certs/ca) : Generate CA (30 years)
* [master/kubeadm-config](../roles/master/kubeadm-config) : Generate kubeadm config file
* [master/first](../roles/master/first) : Execute `kubeadm init` for primary master.
* network-plugin
    * [calico](../roles/network-plugin/calico) : Install Calico network plugin.
* [master/get-join-files](../roles/master/get-join-files) : Collect required files for `kubeadm join`.
    * Generate bootstrap token and get join script.
    * Collect certificates.
* [master/install-kubeconfig](../roles/master/install-kubeconfig) : Install ~/.kube/config file.

## [master-secondary playbook](../master-secondary.yml)

Install secondary master nodes.

* [master/kubeadm-config](../roles/master/kubeadm-config) : Generate kubeadm config file.
* [master/secondary](../roles/master/secondary) : Exeucte `kubeadm init` for secondary masters.
    * Expand certificates and join script.
    * Execute `kubeadm join`.
* [master/install-kubeconfig](../roles/master/install-kubeconfig) : Install ~/.kube/config file.     
* [master/configure](../roles/master/configure) : Configure Scheduleable config etc.

## [worker playbook](../worker.yml)

Install worker nodes.

* [worker](../roles/worker) : Execute `kubeadm join` for worker nodes.
    * Expand join script.
    * Execute `kubeadm join`.

## [networking playbook](../networking.yml)

Deploy networking.

* ingress: Ingress controller
    * [nginx](../roles/networking/ingress/nginx) : Nginx ingress controller
* loadbalander
    * [metallb](../roles/networking/loadbalancer/metallb) : MetalLB

## [storage playbook](../storage.yml)

Deploy storage.

* [local-storage](../roles/storage/local-storage) : Configure `local-storage` Storage Class.
* [rook-nfs](../roles/storage/rook-nfs) : Rook NFS
* [rook-ceph](../roles/storage/rook-ceph) : Rook Ceph
* [default-storage-class](../roles/storage/default-storage-class) : Set default storage class.

## [apps playbook](../apps.yml)

Deploy applications.

* [metrics-server](../roles/apps/metrics-server) : metrics server
* [helm](../roles/apps/helm) : Helm CLI
* [docker-registry](../roles/apps/docker-registry) : Docker Registry

