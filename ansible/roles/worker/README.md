# worker role

Installs Kubernetes control plane for worker nodes.

Execute followings:

* Read join script.
* Execute `kubeadm join`

## Note

If the `/etc/kubernetes/kubelet.conf` file already exists, 
it assumes that the `kubeadm join` has already been executed and will not rerun.
