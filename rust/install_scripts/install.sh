#!/bin/sh
# shellcheck disable=SC1091
# shellcheck disable=SC3018
# shellcheck disable=SC3037

set -e

bash ./supporting_scripts/install_steamcmd.sh
bash ./supporting_scripts/install_rust.sh

systemctl start rustserver

# TODO grep journalctl for logs to show startup progression (Server startup complete)
countdown(){
    secs=$(($1 * 60))
    while [ $secs -gt 0 ]; do
        echo -ne "$secs\033[0K\r"
        sleep 1
        : $((secs--))
    done
}

echo "Waiting 18 minutes for the first time server startup..."
countdown 18

systemctl stop rustserver

echo "Waiting 1 minute for the server to shutdown..."
countdown 1

bash ./supporting_scripts/install_oxide.sh

echo 'All set! :)'