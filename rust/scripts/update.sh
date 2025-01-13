# Script to update server and oxide

echo 'Updating Steam server...'
su - -c "steamcmd +force_install_dir home/rust/server +login anonymous +app_update 258550 validate +logout +quit && echo 'Updating Steam server complete' || echo 'Failed to update server'" steam

echo 'Updating Oxide...'
cd / &&
mkdir temp &&
cd temp &&
wget -O oxide https://umod.org/games/rust/download/develop &&
cd / &&
unzip -o /temp/oxide -d home/rust/server &&
rm -r temp && echo 'Updating Oxide complete' || echo 'Failed updating Oxide'
