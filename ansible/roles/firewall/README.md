# firewalld role

Configure firewalld.

if `firewall_enabled` is `yes`, it enables firewalld and opens ports used by Kubernetes/Calico.

If `firewall_enabled` is `no`, disables firewalld.
