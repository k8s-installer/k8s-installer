# Vagrant を使用して offline installer file を生成する

CentOS 7 / Ubuntu 20.04 用の file を一括生成する手順

## 仮想マシン起動

    $ vagrant up

## offline installer file を生成

    $ ./vagrant-exec.sh

最初に ubuntu 20.04 側で apt repo file を生成し、その後で CentOS 7 側で
yum repo file 含めた全ファイル生成を実行します。

成果物は `outputs/k8s-offline-files.tar.gz` に生成されます。
[HowToVagrant.md](./HowToVagrant.md)を参照してください。
