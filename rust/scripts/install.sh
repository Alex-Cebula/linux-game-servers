# Script to install dependencies, steamcmd and add steam user

echo 'Installing SteamCMD'
apt update && apt upgrade -y
apt install software-properties-common && dpkg --add-architecture i386
apt-add-repository non-free
apt update
apt install steamcmd
adduser steam
su -c 'steamcmd && quit' steam
