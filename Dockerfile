FROM steamcmd/steamcmd:ubuntu-20
ENV HOME /home/baro
ENV PUID 1000
ENV PGID 1000

EXPOSE 27015/udp 27016/udp

# Add user to run the servber
RUN useradd -m baro

VOLUME [ "/home/baro/.local/share/Daedalic Entertainment GmbH/Barotrauma" ]
VOLUME /server/Data

# Directory setup
WORKDIR /server
RUN mkdir -p "/home/baro/.local/share/Daedalic Entertainment GmbH/Barotrauma" && chown -R baro:baro /server /home/baro

# Install
USER baro
RUN steamcmd +force_install_dir /server +login anonymous +app_update 1026340 +quit

# Server looks in the wrong location for steam shared libraries, this symbolic link fixes the error
RUN ln -s ~/.steam/steamcmd/linux64 ~/.steam/sdk64
# Link to serversettings.xml so it can be in the /server/Data directory with other config files
RUN ln -s /server/Data/serversettings.xml /server/serversettings.xml

USER root

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y sudo iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Add files
COPY splash.txt entrypoint.sh /
RUN chmod +x /entrypoint.sh

HEALTHCHECK --interval=10s --start-period=10s --retries=3 CMD if [ $(ss -l | grep -c LISTEN.*27015) == "0" ] ; then exit 1; fi
ENTRYPOINT [ "/entrypoint.sh" ]
