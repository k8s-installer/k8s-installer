# シーケンス

各 playbook, role の実行シーケンスは以下の通り。

## common playbook

全ノードの共通処理

* [installer-defaults](../roles/installer-defaults) : 変数デフォルト値を設定する
* [preflight](../roles/preflight) : プリフライトチェックを行う
* [offline/prepare](../roles/offline/prepare) : オフラインインストール用のファイル転送・展開を行う
* [setproxy](../roles/setproxy) : Proxy 設定を行う (yum/docker)
* [firewall](../roles/firewall) : firewalld の設定を行う
* [preinstall](../roles/preinstall) : プレインストール処理を行う
* container-engine
    * [docker](../roles/container-engine/docker) : Docker インストールを行う
    * [containerd](../roles/container-engine/containerd) : containerd をインストールする (RHEL/CentOS 8)
* [offline/load-images](../roles/offline/load-images) : オフラインインストール時のコンテナロードを行う
* [k8s-packages](../roles/k8s-packages): kubeadm / kubelet のインストールを行う
    * kubernetes yum リポジトリを追加
    * kubeadm, kubelet, kubectl をインストールし、バージョンロック
    * kubelet の --node-ip オプション追加
    * kubelet 起動

## master-first playbook

1台目のマスターノードのインストールを行う

* [master/certs/ca](../roles/master/certs/ca) : CAを生成する (有効期限30年)
* [master/kubeadm-config](../roles/master/kubeadm-config) : kubeadm config ファイルを生成する
* [master/first](../roles/master/first) : 1台目マスターノードの kubeadm init を実行する
* [network-plugin/calico](../roles/network-plugin/calico) : Calico ネットワークプラグインをインストール
* [master/get-join-files](../roles/master/get-join-files) : Join に必要なファイルを収集
    * bootstrap token を生成し、join スクリプトを取得
    * 証明書ファイルを収集
* [master/install-kubeconfig](../roles/master/install-kubeconfig) : ~/.kube/config を設定

## master-secondary playbook

2台目以降のマスターノードのインストールを行う

* [master/kubeadm-config](../roles/master/kubeadm-config) : kubeadm config ファイルを生成する
* [master/secondary](../roles/master/secondary) : 2台目以降のマスターノードの kubeadm join を実行する
    * 収集した証明書ファイル・joinスクリプトを展開
    * kubeadm join を実行
* [master/install-kubeconfig](../roles/master/install-kubeconfig) : ~/.kube/config を設定     
* [master/configure](../roles/master/configure) : Scheduleable 設定などを行う

## worker playbook

ワーカーノードのインストールを行う

* [worker](../roles/worker) : ワーカーノードの kubeadm join を実行する
    * 収集した joinスクリプトを展開
    * kubeadm join を実行

## apps playbook

アプリケーションなどのデプロイを行う。

* ingress: Ingress controller
    * [nginx](../roles/ingress/nginx) : Nginx ingress controller
* [metrics-server](../roles/apps/metrics-server) : metrics server
* [helm](../roles/apps/helm) : Helm CLI
* [local-storage](../roles/storage/local-storage) : local-storage Storage Class 設定
* [rook-nfs](../roles/storage/rook-nfs) : Rook NFS
* [rook-ceph](../roles/storage/rook-ceph) : Rook Ceph
* [default-storage-class](../roles/storage/default-storage-class) : デフォルト Storage Class の設定
* [docker-registry](../roles/apps/docker-registry) : Docker Registry

