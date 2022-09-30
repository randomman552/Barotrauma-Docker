FROM ghcr.io/randomman552/steamcmd:latest
ENV APP_ID=1026340\
    START_CMD=/server/DedicatedServer.exe

EXPOSE 27015/udp 27016/udp

RUN \
    # Install apt dependencies
        apt update \
        && apt upgrade \
        && apt install -y --no-install-suggests --no-install-recommends \
            wget \
            libicu67 \
    # Apt cleanup
        && apt clean \
        && rm -rf /var/lib/apt/lists/* \
    # Install barotrauma dependencies
        && wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb \
        && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb \
    # Cleanup
        && rm -rf libssl1.0.0_1.0.2n-1ubuntu5.10_amd64.deb