# シーケンス

各 playbook, role の実行シーケンスは以下の通り。

## common playbook

全ノードの共通処理

* [installer-defaults](../roles/installer-defaults/README.md) : 変数デフォルト値を設定する
* [preflight](../roles/preflight/README.md) : プリフライトチェックを行う
* [offline/prepare](../roles/offline/prepare/README.md) : オフラインインストール用のファイル転送・展開を行う
* [setproxy](../roles/setproxy/README.md) : Proxy 設定を行う (yum/docker)
* [firewall](../roles/firewall/README.md) : firewalld の設定を行う
* [preinstall](../roles/preinstall/README.md) : プレインストール処理を行う
* container-engine
    * [docker](../roles/container-engine/docker/README.md) : Docker インストールを行う
    * [containerd](../roles/container-engine/containerd/README.md) : containerd をインストールする (RHEL/CentOS 8)
* [offline/load-images](../roles/offline/load-images/README.md) : オフラインインストール時のコンテナロードを行う
* [k8s-packages](../roles/k8s-packages/README.md): kubeadm / kubelet のインストールを行う
    * kubernetes yum リポジトリを追加
    * kubeadm, kubelet, kubectl をインストールし、バージョンロック
    * kubelet の --node-ip オプション追加
    * kubelet 起動

## master-first playbook

1台目のマスターノードのインストールを行う

* [master/certs/ca](../roles/master/certs/ca/README.md) : CAを生成する (有効期限30年)
* [master/kubeadm-config](../roles/master/kubeadm-config/README.md) : kubeadm config ファイルを生成する
* [master/first](../roles/master/first/README.md) : 1台目マスターノードの kubeadm init を実行する
* [network-plugin/calico](../roles/network-plugin/calico/README.md) : Calico ネットワークプラグインをインストール
* [master/get-join-files](../roles/master/get-join-files/README.md) : Join に必要なファイルを収集
    * bootstrap token を生成し、join スクリプトを取得
    * 証明書ファイルを収集
* [master/install-kubeconfig](../roles/master/install-kubeconfig/README.md) : ~/.kube/config を設定

## master-secondary playbook

2台目以降のマスターノードのインストールを行う

* [master/kubeadm-config](../roles/master/kubeadm-config/README.md) : kubeadm config ファイルを生成する
* [master/secondary](../roles/master/secondary/README.md) : 2台目以降のマスターノードの kubeadm join を実行する
    * 収集した証明書ファイル・joinスクリプトを展開
    * kubeadm join を実行
* [master/install-kubeconfig](../roles/master/install-kubeconfig/README.md) : ~/.kube/config を設定     
* [master/configure](../roles/master/configure/README.md) : Scheduleable 設定などを行う

## worker playbook

ワーカーノードのインストールを行う

* [worker](../roles/worker/README.md) : ワーカーノードの kubeadm join を実行する
    * 収集した joinスクリプトを展開
    * kubeadm join を実行

## apps playbook

アプリケーションなどのデプロイを行う。

* ingress: Ingress controller
    * [nginx](../roles/ingress/nginx/README.md) : Nginx ingress controller
* [metrics-server](../roles/apps/metrics-server) : metrics server
* [helm](../roles/apps/helm) : Helm CLI
* [rook-nfs](../roles/storage/rook-nfs) : Rook NFS
* [rook-ceph](../roles/storage/rook-ceph) : Rook Ceph
* [storageclass](../roles/storage/storageclass) : デフォルト Storage Class の設定
* [docker-registry](../roles/apps/docker-registry) : Docker Registry

