# master/first role

マスタノード2台目以降に Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* Kubernetes PKI ファイルを投入 (join-files.tar.gz)
* join スクリプトを投入
* kubeadm join を実行
* ~/.kube/config を投入
