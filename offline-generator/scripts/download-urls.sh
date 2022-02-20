#!/bin/bash

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


# download helm
HELM_VERSION=v3.5.2
HELM_FILE=helm-${HELM_VERSION}-linux-amd64.tar.gz
download https://get.helm.sh/$HELM_FILE

# download containerd
#CONTAINERD_VERSION=1.4.1
#CONTAINERD_FILE=containerd-${CONTAINERD_VERSION}-linux-amd64.tar.gz
#download https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/${CONTAINERD_FILE}
#fi

# download nerdctl
NERDCTL_VERSION=0.17.0
NERDCTL_FILE=nerdctl-${NERDCTL_VERSION}-linux-amd64.tar.gz
download https://github.com/containerd/nerdctl/releases/download/v${NERDCTL_VERSION}/${NERDCTL_FILE}
