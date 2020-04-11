# offline role

オフラインインストールを実行します。
offline_install が yes の場合のみ実行されます。

以下手順が実行されます。

* /opt/kubernetes-offline ディレクトリに RPM リポジトリ、docker イメージファイル、calico.yaml ファイルを展開
* /etc/yum.repos.d/kubernetes-offline.repo を投入
* kubeadm, kubelet, kubectl をインストール
* docker, yum-plugin-versionlock をインストール、docker 起動
* 全コンテナイメージをロード




