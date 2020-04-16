# Kubernetes installer

完全オフラインインストールに対応した Kubernetes インストーラです。
内部では kubeadm を使用しています。

RHEL 7, CentOS 7 に対応しています。Ubuntu 18.04 も一部対応しています。

## 必要環境

* 全マシン(マスター/ワーカー)に以下いずれかの OS がインストールされていること
    * RHEL 7
        * RedHat サブスクリプションの登録(register)が完了していること。
    * CentOS 7
    * Ubuntu 18.04
         * Ansibleインストールのみ、オフラインインストールは未対応
* [Kubeadm 要件](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) を満たすこと
    * 1台あたり最低限2GB以上のメモリ (推奨 4GB以上)
    * 2コア以上の CPU
    * クラスタ内の全マシン間で通信可能なネットワーク (Public / Private いずれも可)
    * ユニークな hostname、MACアドレス、product uuid が各マシン毎に必要
* オンラインインストールを行う場合
    * 全マシン Internet に接続可能であること (Proxy経由での接続も可)
* オフラインインストールを行う場合
    * 事前に [offline-generator](./offline-generator/README.md) を使用して、オフラインインストールファイル(k8s-offline-files.tar.gz)を作成しておくこと。
* HA構成時はL4ロードバランサが必要

RHEL 7 を使用する場合は、以下手順で rhel-7-server-extras-rpms リポジトリを有効にしておく必要があります。

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## インストーラ

以下の2種類のインストーラを提供しています。インストール手順は各 README を参照してください。

* [script](./script/README.md): スクリプトベースの簡易インストーラ
* [ansible](./ansible/README.md): Ansible playbook ベースのインストーラ

オフラインインストールを行う場合は、以下を併用します。

* [offline-generator](./offline-generator/README.md): オフラインインストール用のファイルを生成するジェネレータ

## Kubespray との比較

本 Ansible インストーラと [Kubespray](https://kubespray.io/) の比較です。

* 完全オフラインインストールに対応
    * 本インストーラは完全オフラインインストールに対応しています。
* シンプル
    * Kubesprayに比べると機能を最小限に絞り込んでいるためシンプルです
        * Kubespray は role 配下に 300個程度の yaml がありますが、本インストーラは50個程度です
    * 逆にあまり高度なことはできません          

## License

[MIT License](./LICENSE.txt)
