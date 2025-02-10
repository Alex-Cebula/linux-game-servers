#!/bin/sh

if systemctl is-active -quiet rustserver ; then
    systemctl stop rustserver
fi

# Update rust server
/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit

# Update oxide
bash ./supporting_scripts/install_oxide.sh