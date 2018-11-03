#!/usr/bin/env bash

set -x
set -e

DOTENV_FILE=.env

sudo apt-get update

# upgrade all packages and prevent interactive grub-pc upgrade
sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -y \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  upgrade

sudo apt-get install -y \
    vim \
    tmux \
    git \
    wget \
    curl \
    awscli

wget https://git.io/vpnsetup -O vpnsetup.sh

function loadenv() {
    export $(cat ${1:-$DOTENV_FILE} | xargs)
}

set +x
loadenv
set -x

rm $DOTENV_FILE

sudo sh vpnsetup.sh