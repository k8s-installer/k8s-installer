# Ansible playbook to install kubernetes cluster with kubeadm

Ansible / kubeadm を使用して Kubernetes クラスタを構成するための Playbook です。

オフラインインストールにも対応しています。 

## 必要環境

[こちら](../README.md) を参照してください。

この他に、Python 3, pip3, Ansible が必要です。

### Ansible のインストール

以下手順で Ansible をインストールしてください。

    pip3 install -r requirements.txt
    
オフライン環境で Ansible をインストールする必要がある場合は、
[python-offline-env](https://github.com/tmurakam/python-offline-env) を使用してください。    

## 設定

### インベントリ

インベントリファイル `inventory/hosts` ファイルにインストール先のマシンの情報を設定してください。サンプルは `sample/hosts` ファイルにあります。

グループが以下3つありますので、適切なグループにマシンを定義してください。

* master_first: マスタノードを指定してください。ここに登録できるマシンは1台だけです。
* master_secondary: HA構成を取る場合に2台目以降のマスタノードを指定してください。
* worker: ワーカーノードを指定してください。

マシンの指定方法の例を示します。

    hostname ansible_host=10.0.1.10 ip=10.0.1.10

* hostname: ここに指定した文字列がそのまま Kubernetes のノード名となります。
* ansible_host: ssh でログイン可能なホスト名・IPアドレスを指定します。
    * ホスト名と同一の場合は省略可能です。
* ip: kube-apiserver および kubelet で使用(広告)する IP アドレスを指定します。
    * 省略した場合は、デフォルトゲートウェイに指定されたインタフェースのIPアドレスが使用されます。 

### 変数設定

sample/group_vars/all/*.yml ファイルを inventory/group_vars/all/ ディレクトリにコピーし、適宜編集してください。

* all.yml
    * lb_apiserver_address: HA構成の場合、ロードバランサの FQDN名またはIPアドレスを設定してください。
    * pod_subnet: Podサブネット(CIDR)を指定してください。
* offline.yml    
    * offline_install: オフラインインストールをする場合は yes に設定してください。
* proxy.yml    
    * Internet 接続にプロキシを経由する必要がある場合は、proxy_url, proxy_noproxy を設定してください。
* version.yml
    * インストールする Kubernetes バージョンを適宜指定します。無指定の場合はデフォルト値が使用されます。    

### オフラインインストール

オフラインインストールを行う場合は、[offline-generator](../offline-generator/README.md) を使用して
`k8s-offline-files.tar.gz` を作成し、本ディレクトリで展開してください。

## インストール

以下手順でインストールを行ってください。

    $ ansible-playbook -i inventory/hosts site.yml

以下の playbook が順次実行されます。

* common.yml: Docker/Kubeadm インストール、オフラインリポジトリ設定、Proxy設定など、全マシン共通のインストールが実行されます。
* master-first.yml: 1台目のマスタノードへの Kubernetes デプロイが実行されます。
* master-secondary.yml: 2台目以降のマスタノードへの Kubernetes デプロイが実行されます。
* worker.yml: ワーカーノードへの Kubernetes デプロイが実行されます。

## クラスタのアップグレード

inventory/group_vars/all/version.yml の以下の値を変更してください。

* kube_version: Kubernetes のバージョン
* kubeadm_version, kubelet_version, kubectl_version: kubeadm, kubelet, kubectl のバージョン (RPMバージョン)

注: バージョンは一度に 0.1 ずつしか上げることができませんので、注意してください。

以下手順でマスターノードをアップグレードしてください。

    $ ansible-playbook -i inventory/hosts upgrade-master.yml

以下手順でワーカーノードをアップグレードしてください。
    
    $ ansible-playbook -i inventory/hosts upgrade-worker.yml
