# rook-nfs role

Deploy NFS server using Rook .

Refer https://rook.io/docs/rook/v1.7/nfs.html for details of Rook/NFS.

## Implementation

Use Local Volume of Kubernetes.

* Use `rook_nfs_pv_host` to specify host to generate Local Volume on.
* NFS server also runs on the same host. To use master node, the master node must be Schedulable.

Note: No availability because of using Local volume.

## Variables

* rook_nfs_enabled: Enable rook-nfs (default: false)
* rook_nfs_pv_host: Host to generate local volume PV (default: "")
* rook_nfs_pv_size: Size of local volume PV (default: 10Gi)
* rook_nfs_pv_dir: Directory to place local volume PV (default: /var/lib/rook-nfs)
