# Kubernetes offline installer files generator

## 概要

Kubernetes クラスタをオフラインインストールするために必要なファイルをダウンロード
するスクリプトです。

## 必要環境

* Internet 接続されているマシン。クラスタと同一の OS がインストールされていること（以下いずれか)
    * RHEL 7
    * CentOS 7
* Internet接続に Proxy 経由する必要がある場合は、Proxy 設定が完了していること
* RHEL7 についてはサブスクリプションの登録(register)が完了していること。

## 事前準備

RHEL 7 を使用する場合は、以下手順で rhel-7-server-extras-rpms リポジトリを有効にしておく必要があります。

    $ subscription-manager repos --enable=rhel-7-server-extras-rpms

## オフラインインストールファイルの生成

sudo 可能な一般ユーザ権限でログインしてください。

以下手順でオフラインインストールファイルを生成してください。

    $ sudo ./generate-offline.sh

オフラインインストールファイルは `k8s-offline-files.tar.gz` というファイル名で生成されます。

## 注意事項

本スクリプトを実行するホストには Docker がインストールされます。
