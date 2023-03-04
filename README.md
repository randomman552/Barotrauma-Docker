# Baarotrauma-Docker
Barotrauma dedicated server in a Ubtunu 20 Docker container.

Based on the [steamcmd](https://github.com/steamcmd/docker) Docker image

## File structure
The file structure within the container is as follows:
```
📁home/
├─ 📁baro/
│  ├─📁.local
│  │  ├─📁share
|  |  |  ├─📁Daedalic Entertainment GmbH
|  |  |  |  ├─📁Barotrauma
|  |  |  |  |  ├─ Save files here
📁server/
├─ Server files here
📁scripts/
├─ Scripts here
```

To customise settings, use a volume bound to `/server/Data`. Default config files will be added if none are provided.\
To preserve saves, add a volume for `/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma`.

## Environment variables
Provides the following environment variables for configuration:
| Variable  | Default value | Description                                                                                                    |
|:---------:|:-------------:|:--------------------------------------------------------------------------------------------------------------:|
| PUID      | 1000          | ID of user SteamCMD and the server will be run as                                                              |
| PGID      | 1000          | ID of group SteamCMD and the server will be run as                                                             |

## Running
### Docker CLI
```sh
docker run \
    -p 27015:27015/udp \
    -p 27016:27016/udp \
    -v barotrauma-config:/server \
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
            - ./config:/server/Data
            - ./data:/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma
```
