# Vagrant HA configuration

Vagrant を使用してテスト用の HA クラスタを起動することができます。

本ディレクトリで `vagrant up` を実行すると、以下のコンフィグレーションで VM が起動します。

* lb: 192.168.56.40
    * load balander (haproxy) and NAT router
* master-0: 192.168.56.10
* master-1: 192.168.56.11
* master-2: 192.168.56.12
* worker-0: 192.168.56.20
* worker-1: 192.168.56.21

Note: 全マスター/ワーカーノードのデフォルトゲートウェイは lb に設定されます(NAT I/F ではなく)。
これは kubeadm はデフォルトゲートウェイから自身の IP アドレスを取得するようになっており、NAT I/F
経由でデフォルトゲートウェイを設定してしまうと正常にインストールできないためです。

