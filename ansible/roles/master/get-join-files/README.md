# master/get-join-files role

Get required files (certificates, bootstrap token) to join nodes to the cluster.

Executes followings at first master node.

* Generates bootstrap token and get join command line.
* Collects Kubernetes certificates / key files, and generate `join-files.tar.gz` file.
* Fetch `join-files.tar.gz` and join script file.

The collected files are transferred to the play/files directory in Ansible node.
