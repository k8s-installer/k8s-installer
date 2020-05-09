#!/bin/sh

VER=1.3.4
TARBALL=containerd-$VER.linux-amd64.tar.gz
URL=https://github.com/containerd/containerd/releases/download/v${VER}/${TARBALL}

ANSIBLE_FILES_DIR=../ansible/roles/container-engine/containerd/files/

if [ ! -x /usr/bin/runc ]; then
    if [ -e /etc/redhat-release ]; then
        sudo yum install -y runc
    else
        sudo apt install runc
    fi
fi

if [ ! -x /usr/bin/containerd ]; then
    if [ ! -e $TARBALL ]; then
        curl -SLO $URL
    fi
    sudo tar xvzf $TARBALL -C /usr/bin --strip-components=1
fi

if [ ! -e /etc/containerd/config.toml ]; then
    sudo mkdir -p /etc/containerd
    sudo cp ${ANSIBLE_FILES_DIR}/config.toml /etc/containerd/
fi

if [ ! -e /etc/systemd/system/containerd.service ]; then
    sudo cp ${ANSIBLE_FILES_DIR}/containerd.service /etc/systemd/system/
    sudo systemctl --daemon-reload
    sudo systemctl enable --now containerd
fi
