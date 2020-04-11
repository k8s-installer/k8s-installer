# master/get-join-files role

ノードをクラスタに join するために必要なファイル(証明書・bootstrap token)を取得する role です。

マスタノード1台目で、以下手順が実行されます。

* bootstrap token を作成し、join コマンドを取得
* Kubernetes 証明書・鍵ファイル類を収集し join-files.tar.gz を作成
* join-files.tar.gz と join スクリプトを fetch

収集したファイルは、Ansible 実行ホスト play ディレクトリの files に転送されます。
