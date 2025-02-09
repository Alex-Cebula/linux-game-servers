#!/bin/sh

# shellcheck disable=SC1091
. ./config_helper.sh
. ./install_steamcmd.sh
. ./install_rust.sh

if [ "$(enable_oxide)" = true ]; then 
    . ./install_oxide.sh
fi