# offline/prepare role

オフラインインストールの準備を実行します。
offline_install が yes の場合のみ実行されます。

以下手順が実行されます。

* RHEL / CentOS の場合
    * /opt/kubernetes-offline ディレクトリに RPM リポジトリ、docker イメージファイル、yaml ファイルを展開
    * /etc/yum.repos.d/kubernetes-offline.repo を投入
    * yum-plugin-versionlock をインストール
* Ubuntu の場合
    * /opt/kubernetes-offline ディレクトリに apt リポジトリ、docker イメージファイル、yaml ファイルを展開 
    * /etc/apt/sources.list を削除 (sources.list.backup に移動)   
    * /etc/apt/sources.list.d/kubernetes-offline を投入

コンテナイメージのロードは本 role ではなく [load-images](../load-images) role で実行します。

## 注意事項

Ubuntu ではデフォルトのリポジトリがすべて無効化されます。

元に戻したい場合は、/etc/apt/ ディレクトリの sources.list.backup を sources.list にリネームしてください。
