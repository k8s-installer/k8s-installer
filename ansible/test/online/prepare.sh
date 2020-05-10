#!/bin/sh
for host in 10.240.0.70 10.240.0.71; do
    ssh-keygen -R $host
    ssh -i ~/.vagrant.d/insecure_private_key vagrant@$host ls
done

