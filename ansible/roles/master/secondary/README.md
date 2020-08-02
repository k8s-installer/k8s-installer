# master/secondary role

Installs Kubernetes control plane to secondary master nodes.

Executes:

* Installs Kubernetes PKI files (join-files.tar.gz)
* Installs join script.
* Execute `kubeadm join`.
* Installs `~/.kube/config`

## Note

If the `/etc/kubernetes/pki/ca.key` file already exists, 
it assumes that the `kubeadm join` has already been executed and will not rerun.
