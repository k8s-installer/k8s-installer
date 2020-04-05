#!/bin/bash

# activate firewalld
systemctl enable firewalld
systemctl start firewalld

# change eth0 zone to external
nmcli c mod "System eth0" connection.zone external
firewall-cmd --zone=external --change-interface=eth0

# trust eth1 (private network)
nmcli c mod "System eth1" connection.zone trusted
firewall-cmd --zone=trusted --change-interface=eth1

# set masquerade
firewall-cmd --zone=external --add-masquerade --permanent

firewall-cmd --reload
