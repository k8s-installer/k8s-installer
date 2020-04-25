#!/bin/sh
for host in 10.240.0.52 10.240.0.53; do
    ssh-keygen -R $host
    ssh -i ~/.vagrant.d/insecure_private_key vagrant@$host sudo ip route delete default
done
