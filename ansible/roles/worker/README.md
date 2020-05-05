# master/first role

ワーカーノード Kubernetes コントロールプレーンをインストールします。

以下手順が実行されます。

* join スクリプトを投入
* kubeadm join を実行

## 注意事項

/etc/kubernetes/kubelet.conf が存在する場合は、kubeadm join は完了しているとみなし再実行は行いません。
