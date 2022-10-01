# Baarotrauma-Docker
Barotrauma dedicated server in a Debian based Docker container.
This image is extended from [SteamCMD](https://github.com/randomman552/SteamCMD-Docker)

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁steam/
│  ├─ 📜steamcmd
│  ├─📁.local
│  │  ├─📁share
|  |  |  ├─📁Daedalic Entertainment GmbH
|  |  |  |  ├─📁Barotrauma
📁server/
├─ Server files here
📁scripts/
├─ Scripts here
```

If you wish to preserve the installed server between runs, you should create a volume or a bind mount for the `/server` directory.
To preserve saves, add a volume for `/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma`.

## Environment variables
Provides the following environment variables for configuration:
| Variable  | Default value | Description                                                                                                    |
|:---------:|:-------------:|:--------------------------------------------------------------------------------------------------------------:|
| PUID      | 1000          | ID of user SteamCMD and the server will be run as                                                              |
| PGID      | 1000          | ID of group SteamCMD and the server will be run as                                                             |
| VALIDATE  |               | Whether you want to validate server files on startup (WARNING: Will overwrite your server configuration files) |

## Running
As an example, I will be using this container to run an unmodded gmod server.\
It is possible to set the APP_ID and START_CMD environment variables to use this container directly, but it is recommended to extend this container and add your own custom scripts and environment variables to handle this functionality.
### Docker CLI
```sh
docker run \
    -p 27015:27015/udp \
    -p 27016:27016/udp \
    -v barotrauma:/server \
    -v "barotrauma-data:/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma" \
    ghcr.io/randomman552/steamcmd
```
### Docker Compose
```yml
version: "3.8"
services:
    steamcmd:
        image: ghcr.io/randomman552/barotrauma
        ports:
            - 27015:27015/udp
            - 27016:27016/udp
        volumes:
            - ./server:/server
            - ./data:/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma
```
