# Abstract

## Policy

* Use `kubeadm`
* Enabled complete offline installation.
    * Kubespray does not allow for full offline installation. 
      Each node may be offline, but the ANSIBLE execution host must be online (because it needs to download some files).
    * This installer allows you to download all the files on a different host in advance and transfer them via some media.
* Keep it as simple as possible.
    * Restricted environment (RHEL7/CentOS7, docker, calico)
    * DO NOT deviate substantially from the steps presented in the `kubeadm` document.
