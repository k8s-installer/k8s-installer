# master/secondary role

Installs Kubernetes control plane to secondary master nodes.

Executes:

* Read and parse join script and certificate key files.
* Execute `kubeadm join`.
* Installs `~/.kube/config`

## Note

If the `/etc/kubernetes/pki/ca.key` file already exists, 
it assumes that the `kubeadm join` has already been executed and will not rerun.
