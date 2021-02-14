# master/get-join-files role

Get required files (certificates, bootstrap token) to join nodes to the cluster.

Executes followings at first master node.

* Generates bootstrap token and get join command line.
* Upload certificates and get certificate key.  
* Fetch join script and certificate key files.

The collected files are stored in 'files' dir and read from playbooks.
