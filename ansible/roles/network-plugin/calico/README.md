# network-plugin/calico role

Calico network plugin をインストールします。

## Variables

* calico_ipv4pool_ipip: Enable IP-in-IP? (default: "Never")
* calico_ipv4pool_vxlan: Enable VXLAN? (default: "Never")
* calico_felix_iptablesbackend: Felix iptables backend (default: "Auto") 

## Note

nftables (RHEL8/CentOS8) をサポートするため、calico.yaml に修正を加えてあります。

yaml ファイルの 640行目付近、FELIX_IPTABLESBACKEND を "Auto" に変更しています (Default は Legacy)。

```yaml
kind: DaemonSet
...
spec:
  ...
  template:
    ...
    spec:
      ...
      containers:
        - name: calico-node
          ...
          env:
            - name: FELIX_IPTABLESBACKEND
              value: "Auto"
``` 

本パラメータの詳細は https://docs.projectcalico.org/reference/felix/configuration を参照してください。
