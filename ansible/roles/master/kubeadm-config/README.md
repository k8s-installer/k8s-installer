# master/kubeadm-config role

Generate `/etc/kubernetes/kubeadm-config.yaml` file for `kubeadm init`.

## Variables

* kube_version: Kubernetes version
* ip: API server advertise address (default: default ip address of the node)
* lb_apiserver_address: Load balancer address (default: same as ip)
* lb_apiserver_port: Load balancer port (default: 6443)
* pod_subnet: Pod Subnet CIDR (default: 172.31.0.0/16)
* extra_cert_sans: Extra certificate SANs (default: [])


