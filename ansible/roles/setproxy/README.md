# setproxy role

Proxy 設定を行います。

* /etc/yum.conf: proxy= 設定を投入
* /etc/systemd/system/docker.service.d/http-proxy.conf を投入
* root CA 証明書を必要に応じて投入

## Variables

* proxy_url: Proxy URL (default: "")
* proxy_noproxy: No proxy ホスト (default: "127.0.0.1,localhost")
* proxy_ca_certs: root CA 証明書ファイル名 (default: [])
    * 必要なファイル(*.crt)は files ディレクトリに格納すること
