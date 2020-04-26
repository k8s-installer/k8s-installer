# nfs/server role

NFS サーバをセットアップします。

## Variables

* nfs_enabled: NFS有効にするか (default: no)
* nfs_server_path: NFSサーバパス (default: /var/share/nfs)
* nfs_export_cidr: ExportするCIDR (default: 10.0.0.0/8)
* nfs_export_opts: Exportオプション (default: rw,no_root_squash)
* nfs_domain: ドメイン (default: kubernetes.cluster.local)
