# registry/static role

Docker private registry を起動する role です。

kubelet のみを使用し static pod として起動します。

## 注意事項

* HA構成にはできません。シングルホスト構成になります。 
* 本 role はいずれかの master で実施してください。
** worker では、kubeconfig や CA 証明書などがないため、使用できません。

## Variables

* registry_user: Auth username (default: registry)
* registry_password: Auth password (default: registry)
* registry_port: Registry port (default: 5000)
* registry_dir: Data dir on host (default: /var/lib/registry)
* registry_version: Registry image version (default: 2.7.1)
