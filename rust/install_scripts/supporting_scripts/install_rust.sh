#!/bin/sh
# shellcheck disable=SC2162
# shellcheck disable=SC3045

set -e
LINUX_SERVICE_PATH="/etc/systemd/system/rustserver.service"
RUST_SERVER_PATH="/home/rust/server"


# Verify the server doesn't already exist
if [ -d "$RUST_SERVER_PATH" ]; then
    exit 1
fi

# Create rust user
useradd -m rust

# Install rust server through steamcmd
su rust -c "/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit"

# Verify the service doesn't already exist
if [ -f "$LINUX_SERVICE_PATH" ]; then
    exit 1
fi

read -n 1 -s -r -p 'You will be prompted information required to create the rust server template, press any key to continue...'
echo ""
seed=""
read -p "Server seed: " seed
size=1000
read -p "Server size: " size
max_players=1
read -p "Max players: " max_players
name=""
read -p "Server name: " name
description=""
read -p "Server description: " description
rcon_password=""
read -p "RCON password: " rcon_password


# Create rust linux service
cat > ${LINUX_SERVICE_PATH} << EOF
    [Unit]
    Description=Rust Dedicated Server
    Wants=network-online.target
    After=network-online.target

    [Service]
    Environment=SteamAppId=258550
    Environment=LD_LIBRARY_PATH=/home/rust/server:$LD_LIBRARY_PATH
    Type=simple
    TimeoutSec=900
    Restart=on-failure
    RestartSec=10
    KillSignal=SIGINT
    User=rust
    Group=rust
    WorkingDirectory=/home/rust/server
    ExecStartPre=/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit
    ExecStart=/home/rust/server/RustDedicated -batchmode \
        +server.port 28015 \
        +server.level "Procedural Map" \
        +server.seed $seed \
        +server.worldsize $size \
        +server.maxplayers $max_players \
        +server.hostname "$name" \
        +server.description "$description" \
        +server.identity "$name" \
        +rcon.port 28016 \
        +rcon.password "$rcon_password" \
        +rcon.web 1

    [Install]
    WantedBy=multi-user.target
EOF

systemctl enable rustserver