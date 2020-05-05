# metallb role

Deploy MetalLB loadbalancer.
Supports only Layer 2 mode (not support BGP mode).

For more details, see https://metallb.universe.tf

## Variables

* metallb_enabled: Enable MetalLB (default: no)
* metallb_ip_range: MetalLB IP address pool range (default: 192.168.1.200-192.168.1.210)
