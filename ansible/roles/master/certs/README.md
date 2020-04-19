# master/certs role

master ノード用の証明書を生成する role。

通常は kubeadm が証明書を自動生成しますが、本 role では証明書期限を変更するため、
一部の証明書を個別に生成します。
