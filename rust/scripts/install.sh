# Script to install SteamCMD, install the rust server and create a linux daemon for the server

echo 'Installing SteamCMD'
apt update && 
apt upgrade -y &&
apt install software-properties-common && 
dpkg --add-architecture i386 &&
apt-add-repository non-free &&
apt update &&
apt install steamcmd &&
echo 'Creating steam user' && adduser -m steam &&
su -c 'steamcmd +quit' steam && echo 'SteamCMD installation complete' || 'Failed to install SteamCMD'

echo 'Installing rust server'
echo 'Creating rust user' && useradd -m rust &&
su -c 'cd ~ +/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit' &&
echo 'What do you want your server name to be?' && read -p serverName &&
echo 'What do you want your server description to be?' && read -p serverDescription &&
echo 'How big do you want your server to be? (1500-4500)' && read -p mapSize &&
echo 'What do you want your server seed to be?' && read -p mapSeed &&
echo 'How many players do you want to allow on your server?' && read -p maxPlayers
echo 'What do you want your RCON password to be?' && read -s rconPassword &&
cat > /etc/systemd/system/rustserver.service << EOF
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
      +server.seed ${mapSeed} \
      +server.worldsize ${mapSize} \
      +server.maxplayers ${maxPlayers} \
      +server.hostname "${serverName}" \
      +server.description "${serverDescription}" \
      +server.identity "${serverName}" \
      +rcon.port 28016 \
      +rcon.password "${rconPassword}" \
      +rcon.web 1
  
  [Install]
  WantedBy=multi-user.target
EOF &&
echo 'Server installation complete' || echo 'Failed to install server'

systemctl enable rustserver
