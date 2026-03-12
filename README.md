# Barotrauma-Docker
Barotrauma dedicated server in a Ubuntu 20 Docker container.

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
```

To customise settings, use a volume bound to `/server`. Default config files will be added if none are provided.\
To preserve saves, add a volume for `/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma`.

## Running
### Docker CLI
```sh
docker run \
    -p 27015:27015/udp \
    -p 27016:27016/udp \
    -v barotrauma-server:/server \
    -v "barotrauma-data:/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma" \
    randomman552/barotrauma
```
### Docker Compose
```yml
version: "3.8"
services:
    barotrauma:
        image: ghcr.io/randomman552/barotrauma-docker
        ports:
            - 27015:27015/udp
            - 27016:27016/udp
        volumes:
            - ./server:/server
            - ./data:/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma
```
