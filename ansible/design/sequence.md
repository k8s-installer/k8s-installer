# シーケンス

各 playbook, role の実行シーケンスは以下の通り。

## common playbook

全ノードの共通処理

* [installer-defaults](../roles/installer-defaults/README.md) : 変数デフォルト値を設定する
* [offline](../roles/offline/README.md) : オフラインインストール用のファイル転送・展開を行う
* [setproxy](../roles/setproxy/README.md) : Proxy 設定を行う (yum/docker)
* [firewall](../roles/firewall/README.md) : firewalld の設定を行う
* [preinstall](../roles/preinstall/README.md) : プレインストール処理を行う
* [container-engine/docker](../roles/container-engine/docker/README.md) : Docker コンテナインストール、オフラインインストール時のコンテナロードを行う
* [k8s-packages](../roles/k8s-packages/README.md): kubeadm / kubelet のインストールを行う
    * kubernetes yum リポジトリを追加
    * kubeadm, kubelet, kubectl をインストールし、バージョンロック
    * kubelet の --node-ip オプション追加
    * kubelet 起動

## master-first playbook

1台目のマスターノードのインストールを行う

* [master/first](../roles/master/first/README.md) : 1台目マスターノードの kubeadm init を実行する
    * /etc/kubernetes/kubeadm-config.yml を生成
    * kubeadm init を実行
* [master/install-kubeconfig](../roles/master/install-kubeconfig/README.md) : ~/.kube/config を設定
* [network-plugin/calico](../roles/network-plugin/calico/README.md) : Calico ネットワークプラグインをインストール
* [master/get-join-files](../roles/master/get-join-files/README.md) : Join に必要なファイルを収集
    * bootstrap token を生成し、join スクリプトを取得
    * 証明書ファイルを収集

## master-secondary playbook

2台目以降のマスターノードのインストールを行う

* [master/secondary](../roles/master/secondary/README.md) : 2台目以降のマスターノードの kubeadm join を実行する
    * 収集した証明書ファイル・joinスクリプトを展開
    * kubeadm join を実行
* [master/install-kubeconfig](../roles/master/install-kubeconfig/README.md) : ~/.kube/config を設定     

## worker playbook

ワーカーノードのインストールを行う

* [worker](../roles/worker/README.md) : ワーカーノードの kubeadm join を実行する
    * 収集した joinスクリプトを展開
    * kubeadm join を実行
