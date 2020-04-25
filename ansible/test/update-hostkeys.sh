#!/bin/sh
ssh-keygen -R 10.240.0.50
ssh-keygen -R 10.240.0.51

ssh -i ~/.vagrant.d/insecure_private_key vagrant@10.240.0.50 ls
ssh -i ~/.vagrant.d/insecure_private_key vagrant@10.240.0.51 ls


