# Ansible playbook to install kubernetes cluster with kubeadm

Ansible / kubeadm を使用して Kubernetes クラスタを構成するための Playbook です。

オフラインインストールにも対応しています。 

## Vagrant 設定について

vagrant up を実行すると、以下のコンフィグレーションで VM が起動します。

* lb: 10.240.0.40
    * load balander (haproxy) and NAT router
* master-0: 10.240.0.10
* master-1: 10.240.0.11
* master-2: 10.240.0.12
* worker-0: 10.240.0.20
* worker-1: 10.240.0.21

Note: 全マスター/ワーカーノードのデフォルトゲートウェイは lb に設定されます(NAT I/F ではなく)。
これは kubeadm はデフォルトゲートウェイから自身の IP アドレスを取得するようになっており、NAT I/F
経由でデフォルトゲートウェイを設定してしまうと正常にインストールできないためです。

## 設定

### インベントリ

hosts ファイルにインストール先のマシンの情報を設定してください。

* master_first: マスタノードを指定してください。
* master_secondary: HA構成を取る場合に2台目以降のマスタノードを指定してください。
* worker: ワーカーノードを指定してください。

### 変数設定

group_vars/all.sample.yml を group_vars/all.yml にコピーし、適宜編集してください。

* lb_apiserver_address: マスタノードのDNS/IPアドレス (HA構成の場合はロードバランサ) を設定してください。
* offline_install: オフラインインストールをする場合は yes に設定してください。
    * 予め k8s-offline-files.tar.gz を本ディレクトリで展開しておく必要があります。
* Internet 接続にプロキシを経由する必要がある場合は、proxy_url, proxy_noproxy を設定してください。    

## インストール

以下手順でインストールを行ってください。

    $ ansible-playbook -i hosts site.yml

以下の playbook が順次実行されます。

* common.yml: Docker/Kubeadm インストール、オフラインリポジトリ設定、Proxy設定など、全マシン共通のインストールが実行されます。
* master-first.yml: 1台目のマスタノードへの Kubernetes デプロイが実行されます。
* master-secondary.yml: 2台目以降のマスタノードへの Kubernetes デプロイが実行されます。
* worker.yml: ワーカーノードへの Kubernetes デプロイが実行されます。
