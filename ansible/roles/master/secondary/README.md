# master/secondary role

マスタノード2台目以降に Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* Kubernetes PKI ファイルを投入 (join-files.tar.gz)
* join スクリプトを投入
* kubeadm join を実行
* ~/.kube/config を投入

## 注意事項

/etc/kubernetes/pki/ca.key ファイルが存在している場合はすでに join は実行されているとみなし、
再実行は行われません。
