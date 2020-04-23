#!/bin/sh

download() {
  url="$1"
  file="$2"

  if [ ! -e "offline-files/$file" ]; then
    echo "===> Downloading: $url"
    curl -SL "$url" > "offline-files/$file" || exit 1
  fi
}

CALICO_VERSION=v3.13
METRICS_SERVER_VERSION=v0.3.6
HELM_VERSION=v3.1.2

# download yamls
download https://docs.projectcalico.org/${CALICO_VERSION}/manifests/calico.yaml calico.yaml
download https://github.com/kubernetes-sigs/metrics-server/releases/download/${METRICS_SERVER_VERSION}/components.yaml metrics-server.yaml

# download helm
HELM_FILE=helm-${HELM_VERSION}-linux-amd64.tar.gz
download https://get.helm.sh/$HELM_FILE $HELM_FILE
