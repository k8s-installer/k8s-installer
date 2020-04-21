# master/kubeadm-config role

kubeadm init に必要となる /etc/kubernetes/kubeadm-config.yaml ファイルを生成します。

## Variables

* kube_version: Kubernetes version
* ip: API server advertise address
* lb_apiserver_address: Load balancer address
* lb_apiserver_port: Load balancer port
* pod_subnet: Pod Subnet CIDR (default: 192.168.0.0/16)
* extra_cert_sans: Extra certificate SANs (default: [])


