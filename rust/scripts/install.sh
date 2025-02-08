# Script to install SteamCMD, install the rust server and create a linux daemon for the server
LINUX_SERVICE_PATH="/etc/systemd/system/rustserver.service"

echo 'Installing SteamCMD'
echo '-------------------'
echo 'Step 1: Updating repositories...' apt update && apt upgrade -y &&
echo 'Step 2: Installing software properties common package...' && apt install software-properties-common && 
echo 'Step 3: Installing 32 bit x86 architecture debian package...' && dpkg --add-architecture i386 &&
echo 'Step 4: Adding non-free repository...' && apt-add-repository non-free &&
echo 'Step 5: Updating repositories...' && apt update &&
echo 'Step 6: Installing steamcmd...' && apt install steamcmd &&
echo 'Step 7: Adding steam linux user...' && adduser -m steam &&
echo 'Step 8: Testing steam installation...' && su -c 'steamcmd +quit' steam && echo 'SteamCMD installation complete' || 'Failed to install SteamCMD'

echo 'Installing rust server'
echo '-----------------------'
echo 'Step 1: Creating rust linux user' && useradd -m rust &&
echo 'Step 2: Installing rust server through steamcmd...' && su -c 'cd ~ +/usr/games/steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /home/rust/server +login anonymous +app_update 258550 +quit' &&
echo 'Step 3: Creating rust service linux service' &&
read -n 1 -s -r -p 'You will be prompted information required to create the rust server template, press any key to continue...' && 
echo 'What do you want your server name to be?' && read -p serverName &&
echo 'What do you want your server description to be?' && read -p serverDescription &&
echo 'How big do you want your server to be? (1500-4500)' && read -p mapSize &&
echo 'What do you want your server seed to be?' && read -p mapSeed &&
echo 'How many players do you want to allow on your server?' && read -p maxPlayers
echo 'What do you want your RCON password to be?' && read -s rconPassword &&
echo 'Step 4: Writing linux service to $LINUX_SERVICE_PATH' +  && cat > ${LINUX_SERVICE_PATH} << EOF
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
systemctl enable rustserver &&
echo 'Server installation complete!' &&
echo 'To start the server run: systemctl start rustserver' &&
echo 'To stop the server run: systemctl stop rustserver' &&
echo 'To restart the server run: systemctl restart rustserver' || echo 'Failed to install server'

