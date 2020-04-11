# upgrade roles

Kubernetes クラスタを upgrade する role 群です。

* drain: upgrade 前にノードを drain する
* update-kubeadm: kubeadm をアップグレードする
* upgrade-master: master ノードをアップグレードする
* upgrade-worker: worker ノードをアップグレードする
* upgrade-kubelet: kubelet をアップグレードする
* uncordon: upgrade 後にノードを uncordon する
