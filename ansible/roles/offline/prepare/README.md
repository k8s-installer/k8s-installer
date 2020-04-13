# offline/prepare role

オフラインインストールの準備を実行します。
offline_install が yes の場合のみ実行されます。

以下手順が実行されます。

* /opt/kubernetes-offline ディレクトリに RPM リポジトリ、docker イメージファイル、calico.yaml ファイルを展開
* /etc/yum.repos.d/kubernetes-offline.repo を投入
* yum-plugin-versionlock をインストール

全コンテナイメージのロードは `docker` role で実行します。
