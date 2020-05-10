# setproxy role

Proxy 設定を行います。

* /etc/yum.conf: proxy= 設定を投入
* /etc/systemd/system/docker.service.d/http-proxy.conf を投入
* root CA 証明書を必要に応じて投入

root CA 証明書 (.crt ファイル) を files ディレクトリに格納しておくと、自動的に
投入します。

## Variables

* proxy_url: Proxy URL (default: "")
* proxy_noproxy: No proxy ホスト (default: "127.0.0.1,localhost")
