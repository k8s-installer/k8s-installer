# firewalld role

firewalld の設定を行います。

firewall_enabled: が yes の場合は、firewalld を有効化し、
Kubernetes/Calico が使用するポートを開放します。

firewall_enabled: が no の場合は、firewalld を無効化します。
