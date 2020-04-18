# Kubernetes installer (script based)

## 概要

Kubernetes クラスタを kubeadm を使用してインストールするスクリプトです。

オンラインインストール・オフラインインストールの両方に対応しています。

## 必要環境

[こちら](../README.md) を参照してください。

注: 本スクリプトは RHEL 7 / CentOS 7 にのみ対応しています。Ubuntu には対応していません。

## 設定

config.sample.sh を config.sh にコピーし、設定を行ってください。

* オフラインインストールを行う場合は、`OFFLINE_INSTALL` を `yes` に設定してください。
* Internet接続に Proxy を経由する必要がある場合は、`PROXY_URL`, `NO_PROXY` の値を設定してください。
* HA構成にする場合はロードバランサのDNS名(FQDN)とポート番号をを `LOAD_BALANCER_DNS`, `LOAD_BALANCER_PORT` に指定してください。
    * ロードバランサは、指定したポートを全マスターノードにL4負荷分散するよう設定しておく必要があります。
    * 詳細は [kubeadmを使用した高可用性クラスターの作成](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/high-availability/) を参照してください。
    
## Docker / kubeadm インストール

全マシン(マスター・ワーカー)に対して Docker と kubeadm をインストールします。

sudo 可能な一般ユーザ権限でログインしてください(root での直接ログインは不可)。
以下手順でインストールを実行してください。

    $ sudo ./install-common.sh

## マスターノードのインストール

マスターノード上で kubeadm を使用して Kubernetes マスターコントロールプレーンをインストールします。

    # シングルマスター構成の場合
    $ sudo ./install-master-single.sh
    
    # HA構成の場合(1台目のマスターノード)
    $ sudo ./install-master-ha.sh

インストールには数分かかります。
画面にワーカーノードを join するための `kubeadm join` コマンドラインが表示されるので、メモしてください。

インストールが完了したら、以下手順で ~/.kube/config をインストールします。

    $ ./install-kubeconfig.sh

`kubectl cluster-info` を実施し、正常にコントロールプレーンが動作していることを確認します。

最後に calico ネットワークアドオンをインストールします。

    $ ./install-cni.sh

## HA構成: 残りのマスターノードのインストール

HA構成の2台目以降のマスターノードのインストール手順は、
[kubeadmを使用した高可用性クラスターの作成](https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/high-availability/) の
「残りのコントロールプレーンノードの手順」を参照してください。

## ワーカーノードのインストール

各ワーカーノードで、上記取得した `kubeadm join` コマンドを sudo 付きで実行し、
Kubernetes クラスタに参加してください。
