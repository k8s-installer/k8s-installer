# metrics-server role

Installs [metrics-server](https://github.com/kubernetes-sigs/metrics-server).

## Note

Following arguments are added to metrics server.

* --kubelet-preferred-address-types=InternalIP
* --kubelet-insecure-tls
