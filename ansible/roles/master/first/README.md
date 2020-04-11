# master/first role

マスタノード1台目に Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* /etc/kubernetes/kubeadm-config.yml を作成
* kubeadm init を実行
* ~/.kube/config を投入
* calico plugin をインストール
* bootstrap token を作成し、join コマンドを取得
* Kubernetes PKI ファイル類を収集し masters.tar.gz を作成
* masters.tar.gz と join スクリプトを fetch
