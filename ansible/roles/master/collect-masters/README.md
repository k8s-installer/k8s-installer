# master/collect-masters role

マスタノード1台目で証明書ファイル類を収集する role です。

以下手順が実行されます。

* bootstrap token を作成し、join コマンドを取得
* Kubernetes PKI ファイル類を収集し masters.tar.gz を作成
* masters.tar.gz と join スクリプトを fetch

収集したファイルは、Ansible 実行ホスト play ディレクトリの files に転送されます。
