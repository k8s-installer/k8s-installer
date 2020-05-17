#!/bin/sh

download() {
  url="$1"
  file="$2"

  if [ -z "$file" ]; then
      file=$(basename $url)
  fi

  if [ ! -e "$file" ]; then
    echo "===> Downloading: $url"
    curl -SL "$url" > "$file" || exit 1
  else
    echo "===> $file already exists, skip download"
  fi
}

CALICO_VERSION=v3.14
METRICS_SERVER_VERSION=v0.3.6

# download yamls
download https://docs.projectcalico.org/${CALICO_VERSION}/manifests/calico.yaml
download https://github.com/kubernetes-sigs/metrics-server/releases/download/${METRICS_SERVER_VERSION}/components.yaml metrics-server.yaml
