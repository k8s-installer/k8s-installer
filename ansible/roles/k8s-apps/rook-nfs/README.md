# rook-nfs role

Rook を使用して NFS サーバを起動します。

Rook/NFS の詳細は https://rook.io/docs/rook/v1.3/nfs.html を参照してください。

## 実装について

Kubernetes の Local Volume を使用します。

* Local volume を作成するホストは `rook_nfs_pv_host` で指定してください。
* NFSサーバも本ホスト上で動作します。マスターノードで動作させる場合は、マスターノードを Schedulable にしなければなりません。

Local volume を使用するので可用性はありません。

## Variables

* rook_nfs_enabled: rook-nfs を有効にする (default: false)
* rook_nfs_pv_host: local volume PV を作成するホスト。指定必須。 (default: "")
* rook_nfs_pv_size: local volume PV のサイズ (default: 10Gi)
* rook_nfs_pv_dir: local volume PV を配置するディレクトリ (default: /var/lib/rook-nfs)
