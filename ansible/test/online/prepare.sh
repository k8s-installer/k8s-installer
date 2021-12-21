#!/bin/sh
for host in 192.168.56.70 192.168.56.71; do
    ssh-keygen -R $host
    ssh -i ~/.vagrant.d/insecure_private_key vagrant@$host ls
done

