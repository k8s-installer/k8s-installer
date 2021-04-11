#!/bin/sh

. ./scripts/load-config.sh

VER=1.3.6
TARBALL=containerd-$VER-linux-amd64.tar.gz
URL=https://github.com/containerd/containerd/releases/download/v${VER}/${TARBALL}

ANSIBLE_FILES_DIR=../ansible/roles/container-engine/containerd/files/

if [ ! -x /usr/bin/runc ]; then
    if [ -e /etc/redhat-release ]; then
        $SUDO yum install -y runc
    else
        $SUDO apt install -y runc
    fi
fi

if [ ! -x /usr/bin/containerd ]; then
    if [ ! -e $TARBALL ]; then
        curl -SLO $URL
    fi
    $SUDO tar xvzf $TARBALL -C /usr/bin --strip-components=1
fi

if [ ! -e /etc/containerd/config.toml ]; then
    $SUDO mkdir -p /etc/containerd
    $SUDO cp ${ANSIBLE_FILES_DIR}/config.toml /etc/containerd/
fi

if [ ! -e /etc/systemd/system/containerd.service ]; then
    $SUDO cp ${ANSIBLE_FILES_DIR}/containerd.service /etc/systemd/system/
    $SUDO systemctl --daemon-reload
    $SUDO systemctl enable --now containerd
fi
