#!/bin/sh

# shellcheck disable=SC1091
. ./config_helper.sh
# shellcheck disable=SC1091
. ./install_steamcmd.sh
# shellcheck disable=SC1091
. ./install_rust.sh

if [ "$(enable_oxide)" = true ]; then 
    # shellcheck disable=SC1091
    . ./install_oxide.sh
fi