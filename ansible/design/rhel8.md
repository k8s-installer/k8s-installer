# RHEL/CentOS 8 support

* RHEL/CentOS 8 does not have docker, and docker-ce is not supported.
So use [containerd](../roles/container-engine/containerd/README.md) instead of docker.
* [calico](../roles/network-plugin/calico/README.md) does not support `nftables` by default, 
so change configuration to use `nftables`.
