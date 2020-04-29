# registry role

Docker private registry を起動する role です。

以下の2モードのいずれかでインストールが可能です。

1. PV mode: PV を使用して Pod 起動する
2. static-pod mode: PV は使用せず、kubelet のみを使用し static pod として起動する

## PV mode

ストレージとして PV (Persistent Volume) を使用し、Kubernetes 上で Registry を Pod 起動します。

`registry_pvc_storage_class` で使用するストレージクラス、`registry_pvc_size` で使用するストレージサイズを指定してください。

ストレージクラスはデフォルトでは、`rook-nfs` role で作成する `rook-nfs-share1` を使用するようになっています。
詳細は [rook-nfs](../rook-nfs/README.md) を参照してください。

## static-pod mode

Static pod として Registry を起動します。PV は使用せず、本 role を実行するホスト上のファイルシステムを直接使用します。

static-pod モードの場合は、本 role はいずれかの master で実施してください。
worker では、kubeconfig や CA 証明書などがないため、使用できません。

## 注意事項

* HA構成にはできません。シングルホスト構成になります。 

## Variables

* registry_enabled: Registry enabled? (default: no)
* registry_type: Registry type, `pv` or `static-pod` (default: pv)
* registry_user: Auth username (default: registry)
* registry_password: Auth password (default: registry)
* registry_version: Registry image version (default: 2.7.1)

PV mode only:

* registry_pvc_storage_class: PV Storage class name (default: rook-nfs-share1)
* registry_pvc_size: PV Storage size (default: 10Gi)

static-pod mode only:

* registry_port: Registry port (default: 5000)
* registry_dir: Data dir on host (default: /var/lib/registry)
