# Vagrant HA configuration

Vagrant を使用してテスト用の HA クラスタを起動することができます。

本ディレクトリで `vagrant up` を実行すると、以下のコンフィグレーションで VM が起動します。

* lb: 10.240.0.40
    * load balander (haproxy) and NAT router
* master-0: 10.240.0.10
* master-1: 10.240.0.11
* master-2: 10.240.0.12
* worker-0: 10.240.0.20
* worker-1: 10.240.0.21

Note: 全マスター/ワーカーノードのデフォルトゲートウェイは lb に設定されます(NAT I/F ではなく)。
これは kubeadm はデフォルトゲートウェイから自身の IP アドレスを取得するようになっており、NAT I/F
経由でデフォルトゲートウェイを設定してしまうと正常にインストールできないためです。

