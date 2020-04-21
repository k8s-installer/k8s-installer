# master/longer-certs role

Kubernetes各種証明書を、長い有効期限(1年以上)のものに入れ替える role です。

## Variables

* cert_not_after: 有効期限 (default: +1826d, 5年)

## 注意事項

Kubernetes をアップグレードすると証明書の有効期限が1年に戻ってしまいますので、
その場合は再度本 role を実行する必要があります。
