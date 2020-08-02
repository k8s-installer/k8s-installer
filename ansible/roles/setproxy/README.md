# setproxy role

Set up proxy config.

* /etc/yum.conf: Add `proxy=` config.
* Installs `/etc/systemd/system/docker.service.d/http-proxy.conf` file.
* Install root CA certificates if needed.

If you put root CA certificates (.crt file) in `files` dir, this role installs them automatically.

## Variables

* proxy_url: Proxy URL (default: "")
* proxy_noproxy: No proxy hosts (default: "127.0.0.1,localhost")
