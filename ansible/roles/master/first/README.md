# master/first role

マスタノード1台目に Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* kubeadm init を実行

## 注意事項

/etc/kubernetes/admin.conf ファイルが存在している場合はすでに kubeadm init が実行済みと判断し、
再実行は行われません。
