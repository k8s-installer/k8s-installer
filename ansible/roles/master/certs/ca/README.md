# master/cacerts role

master ノード用の CA 証明書を生成する role。

通常は kubeadm が証明書を自動生成しますが、本 role では証明書期限を変更するため、
CA証明書を個別に生成します。

## variables

* ca_expiry: 証明書有効期限 (default: 262980h = 30yrs)