#! /bin/bash
cat /splash.txt

# Update server if needed
sudo -u baro steamcmd +force_install_dir /server/ +login anonymous +app_update 1026340 +quit

# Update permissions
usermod -u ${PUID} baro
groupmod -g ${PGID} baro
chown -R baro:baro /server /home/baro

# Run server
sudo -u baro /server/DedicatedServer
