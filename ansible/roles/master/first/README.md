# master/first role

Installs kubernetes control plane to first master node.

Executes:

* `kubeadm init`

## Note

If the `/etc/kubernetes/admin.conf` file already exists, 
it assumes that the `kubeadm init` has already been executed and will not rerun.
