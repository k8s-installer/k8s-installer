#!/bin/bash

. ./config.sh

if [ -z "$PROXY_URL" ]; then
    exit 0
fi

export http_proxy=$PROXY_URL
export https_proxy=$PROXY_URL

# yum proxy
grep "^proxy=$PROXY_URL" /etc/yum.conf > /dev/null || echo "proxy=$PROXY_URL" >> /etc/yum.conf

# docker proxy
mkdir -p /etc/systemd/system/docker.service.d

cat <<EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$PROXY_URL" "HTTPS_PROXY=$PROXY_URL" "NO_PROXY=$NO_PROXY"
EOF

systemctl daemon-reload
systemctl restart docker > /dev/null 2>&1

exit 0


#echo "http_proxy=$http_proxy" >> /etc/environment
#echo "https_proxy=$https_proxy" >> /etc/environment
#echo "no_proxy=$NO_PROXY" >> /etc/environment
