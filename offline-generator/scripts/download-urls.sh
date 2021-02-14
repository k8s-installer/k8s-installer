#!/bin/sh

. ./scripts/load-config.sh

OUTDIR=outputs/offline-files
if [ ! -e $OUTDIR ]; then
    mkdir -p $OUTDIR
fi

download() {
  url="$1"
  file="$2"

  if [ -z "$file" ]; then
      file=$(basename $url)
  fi

  if [ ! -e "$OUTDIR/$file" ]; then
    echo "===> Downloading: $url"
    curl -SL "$url" > "$OUTDIR/$file" || exit 1
  else
    echo "===> $file already exists, skip download"
  fi
}

HELM_VERSION=v3.5.2
CONTAINERD_VERSION=1.4.1

# download helm
HELM_FILE=helm-${HELM_VERSION}-linux-amd64.tar.gz
download https://get.helm.sh/$HELM_FILE

# download containerd
if [ "$CONTAINER_ENGINE" = "containerd " ]; then
    CONTAINERD_FILE=containerd-${CONTAINERD_VERSION}-linux-amd64.tar.gz
    download https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/${CONTAINERD_FILE}
fi
