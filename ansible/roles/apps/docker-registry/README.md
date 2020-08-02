# docker-registry role

Deploy Docker private registry.

You can install in either of the following two modes.

1. PV mode: Starting the Pod using PV.
2. static-pod mode: Do not use PV, only use kubelet and start as static pod.

## PV mode

Use PV (Persistent Volume) as storage, and deploy the registry on the kubernetes cluster.

Specify storage class with `registry_pvc_storage_class` and size with `registry_pvc_size`.

By default, uses storage class `rook-nfs-share1` created by `rook-nfs` role.
See [rook-nfs](../rook-nfs/README.md).

## static-pod mode

Deploy registry as Static pod. Do not use PV and use host filesystem.

To use static-pod mode, apply this role on the one of the master node.
You can't use worker node because they does not have kubeconfig and CA certificates.

## Note

* No HA mode, single host only.

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
