# Kubernetes single master installer

## 概要

Kubernetes クラスタをシングルマスタモードでインストールするスクリプトです。

オンラインインストール・オフラインインストールの両方に対応しています。

## 必要環境

マスターノード・ワーカーノードには以下いずれかの OS がインストールされていること。
(全マシンで同一のOSがインストールされていること)

* RHEL 7
* CentOS 7

RHEL7 を使用する場合は、サブスクリプションの登録(register)が完了していること。

オンラインインストールを行う場合は、全マシン Internet に接続可能であること。
(Proxy経由での接続も可)

オフラインインストールを行う場合は、事前にオフラインインストールファイルを
(k8s-offline-files.tar.gz)を生成して本ディレクトリに配置しておくこと。

## 事前準備

RHEL 7 を使用する場合は、以下手順で rhel-7-server-extras-rpms リポジトリを有効にしておく必要があります。

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## 設定

config.sample.sh を config.sh にコピーし、設定を行ってください。

* オフラインインストールを行う場合は、`OFFLINE_INSTALL` を `yes` に設定してください。
* Internet接続に Proxy を経由する必要がある場合は、`PROXY_URL`, `NO_PROXY` の値を設定してください。

## Docker / kubeadm インストール

全マシン(マスター・ワーカー)に対して Docker と kubeadm をインストールします。

sudo 可能な一般ユーザ権限でログインしてください(root での直接ログインは不可)。
以下手順でインストールを実行してください。

    $ sudo ./install.sh

## マスターノードのインストール

マスターノード上で kubeadm を使用して Kubernetes マスターコントロールプレーンをインストールします。

    $ sudo ./install-master.sh

インストールには数分かかります。
画面にワーカーノードを join するための `kubeadm join` コマンドラインが表示されるので、メモしてください。

インストールが完了したら、以下手順で ~/.kube/config をインストールします。

    $ ./install-kubeconfig.sh

`kubectl cluster-info` を実施し、正常にコントロールプレーンが動作していることを確認します。

最後に calico ネットワークアドオンをインストールします。

    $ ./install-cni.sh

## ワーカーノードのインストール

各ワーカーノードで、上記取得した `kubeadm join` コマンドを sudo 付きで実行し、
Kubernetes クラスタに参加してください。
