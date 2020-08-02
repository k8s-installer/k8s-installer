# offline/prepare role

Prepare offline installation.
It is executed only when `offline_install` is `yes`.

* For RHEL / CentOS
    * Extracts RPM repo, docker image files, yaml files to `/opt/kubernetes-offline` directory.
    * Install `/etc/yum.repos.d/kubernetes-offline.repo` file.
    * Install `yum-plugin-versionlock`.
* For Ubuntu
    * Extracts apt repo, docker image filea, yaml files to `/opt/kubernetes-offline` directory.
    * Remove `/etc/apt/sources.list` (moves to `sources.list.backup` file)
    * Install `/etc/apt/sources.list.d/kubernetes-offline` file.

Note: Loading container images is executed by [load-images](../load-images) role, not this one. 

## Caution

For Ubuntu, all default repositories are disabled.

If you want to restore, rename `sources.list.backup` to `souces.list` in /etc/apt/ directory.
