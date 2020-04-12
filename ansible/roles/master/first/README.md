# master/first role

マスタノード1台目に Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* /etc/kubernetes/kubeadm-config.yml を作成
* kubeadm init を実行
* ~/.kube/config を投入
* calico plugin をインストール

## Variables

* kube_version: Kubernetes version
* ip: API server advertise address
* lb_apiserver_address: Load balancer address
* lb_apiserver_port: Load balancer port
* pod_subnet: Pod Subnet CIDR


