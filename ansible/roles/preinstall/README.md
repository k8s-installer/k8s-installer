# preinstall role

以下手順を実施します。

* 共通に使用するパッケージをインストール(NFS client, etc)
* SELinux を無効化
* Swap を無効化
* bridge-nf-call-iptables sysctl 設定を追加
* モジュール(overlay,br_netfilter)をロード
* cfssl をインストール
