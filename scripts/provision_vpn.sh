#!/usr/bin/env bash

set -x
set -e

DOTENV_FILE=.env
VPN_SCRIPT=vpnsetup.sh

function fail_if_missing_dotenv_file() {
    ls $DOTENV_FILE > /dev/null
}

function upgrade_system_packages_and_prevent_interactive() {
    sudo apt-get update
    sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -y \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        upgrade
}

function install_general_packages() {
    sudo apt-get install -y \
        vim \
        tmux \
        git \
        wget \
        curl \
        awscli
}

function download_vpn_script() {
    wget https://git.io/vpnsetup -O $VPN_SCRIPT
}

function loadenv() {
    export $(cat ${1:-$DOTENV_FILE} | xargs)
}

function update_creds_in_vpn_script() {
    sed -i "s/YOUR_IPSEC_PSK=''/YOUR_IPSEC_PSK='$YOUR_IPSEC_PSK'/g" $VPN_SCRIPT
    sed -i "s/YOUR_USERNAME=''/YOUR_USERNAME='$YOUR_USERNAME'/g" $VPN_SCRIPT
    sed -i "s/YOUR_PASSWORD=''/YOUR_PASSWORD='$YOUR_PASSWORD'/g" $VPN_SCRIPT
}

function install_vpn() {
    sudo sh $VPN_SCRIPT
}

function cleanup() {
    rm $DOTENV_FILE
    rm $VPN_SCRIPT
}

fail_if_missing_dotenv_file
upgrade_system_packages_and_prevent_interactive
install_general_packages
download_vpn_script

set +x
loadenv
update_creds_in_vpn_script
set -x

install_vpn
cleanup
