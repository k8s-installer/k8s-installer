#!/bin/sh

# Copy pre-configured yaml, to prevent overwrite.
./scripts/process-yaml.sh

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

CALICO_VERSION=v3.13
METRICS_SERVER_VERSION=v0.3.6
HELM_VERSION=v3.1.2
CONTAINERD_VERSION=1.3.4

# download yamls
download https://docs.projectcalico.org/${CALICO_VERSION}/manifests/calico.yaml
download https://github.com/kubernetes-sigs/metrics-server/releases/download/${METRICS_SERVER_VERSION}/components.yaml metrics-server.yaml

# download helm
HELM_FILE=helm-${HELM_VERSION}-linux-amd64.tar.gz
download https://get.helm.sh/$HELM_FILE

# download runC
RUNC_VERSION=v1.0.0-rc10
download https://github.com/opencontainers/runc/releases/download/${RUNC_VERSION}/runc.amd64 runc.amd64_${RUNC_VERSION}

# download containerd
CONTAINERD_FILE=containerd-${CONTAINERD_VERSION}.linux-amd64.tar.gz
download https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/${CONTAINERD_FILE}
