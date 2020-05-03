# RHEL/CentOS 8 support

* RHEL/CentOS 8 には docker が付属せず、docker-ce もサポートされない。
このため、docker は使用せず [containerd](../roles/container-engine/containerd/README.md) を使用する。
* [calico](../roles/network-plugin/calico/README.md) はデフォルト状態では nftables をサポートしないため、nftables を使用するようコンフィグレーションを変更する。
