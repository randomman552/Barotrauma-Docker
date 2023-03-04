FROM steamcmd/steamcmd:ubuntu-20
ENV LD_LIBRARY_PATH /server/linux64
ENV HOME /home/baro
ENV PUID 1000
ENV PGID 1000

# Add user to run the servber
RUN useradd -m baro

# Install barotrauma
USER baro
RUN steamcmd +force_install_dir /server/ +login anonymous +app_update 1026340 +quit
USER root

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y sudo iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Add files
COPY splash.txt entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 27015/udp 27016/udp
VOLUME [ "/home/steam/.local/share/Daedalic Entertainment GmbH/Barotrauma", "/server/Data" ]
HEALTHCHECK --interval=10s --start-period=10s --retries=3 CMD if [ $(ss -l | grep -c LISTEN.*27015) == "0" ] ; then exit 1; fi
ENTRYPOINT [ "/entrypoint.sh" ]
