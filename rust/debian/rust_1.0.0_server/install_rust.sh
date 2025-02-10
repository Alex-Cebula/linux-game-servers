#!/bin/sh
# POSIX-compliant shebang

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
/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit

# Verify the service doesn't already exist
if [ -f "$LINUX_SERVICE_PATH" ]; then
    exit 1
fi

# Create rust linux service
$ /config_prompt

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
    ExecStart= . ./config_helper
        /home/rust/server/RustDedicated -batchmode \
        +server.port $(port) \
        +server.level "Procedural Map" \
        +server.seed $(seed) \
        +server.worldsize $(size) \
        +server.maxplayers $(max_players) \
        +server.hostname "$(name)" \
        +server.description "$(description)" \
        +server.identity "$(name)" \
        +rcon.port $(rcon_port) \
        +rcon.password "$(rcon_password)" \
        +rcon.web $(rcon_enabled)

    [Install]
    WantedBy=multi-user.target
EOF