#!/bin/sh

CFSSL_VERSION=1.4.1

curl -L https://github.com/cloudflare/cfssl/releases/download/v${CFSSL_VERSION}/cfssl_${CFSSL_VERSION}_linux_amd64 > ./files/cfssl || exit 1
curl -L https://github.com/cloudflare/cfssl/releases/download/v${CFSSL_VERSION}/cfssljson_${CFSSL_VERSION}_linux_amd64 > ./files/cfssljson || exit 1
chmod 755 ./files/cfssl*
