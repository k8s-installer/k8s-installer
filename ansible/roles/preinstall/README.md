# preinstall role

Executes followings.

* Installs common packages (NFS client, etc)
* Disables SELinux.
* Disables swap.
* Adds bridge-nf-call-iptables sysctl config
* Loads modules (overlay,br_netfilter)
* Installs cfssl.
