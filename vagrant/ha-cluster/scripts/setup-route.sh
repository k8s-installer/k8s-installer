#!/bin/sh
# Remove default route (temporal)
ip route del default

# Use lb as default gateway (temporal)
ip route add default via 192.168.56.40

# for rhel/centos
if [ -e /etc/redhat-release ]; then
    # Never set default gateway for eth0 (NAT)
    nmcli con mod "System eth0" ipv4.never-default yes

    # Set default gateway for eth1 (private)
    nmcli con mod "System eth1" ipv4.gateway 192.168.56.40

    systemctl restart network
fi
