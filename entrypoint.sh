#! /bin/bash
cat /splash.txt

# Update server if needed
echo "Starting Update..."
steamcmd +force_install_dir /server/ +login anonymous +app_update 1026340 +quit
echo "Update Finished!"

# Server looks in the wrong location for steam shared libraries, this symbolic link fixes the error
ln -s ~/.steam/steamcmd/linux64 ~/.steam/sdk64

# Run server
/server/DedicatedServer
