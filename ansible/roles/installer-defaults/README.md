# installer-defaults role

The role contains default values of the installer.

Also set yum repository configs to `yum_enablerepo`, `yum_disablerepo` variables (RHEL/CentOS only).

* For online install: Use default repo.
* For offline install: Enable the `kubernetes-offline` repository and disable all others.
