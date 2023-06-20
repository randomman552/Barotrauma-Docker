FROM steamcmd/steamcmd:ubuntu-20
ENV HOME /home/baro
EXPOSE 27015/udp 27016/udp

# Add user to run the servber
RUN useradd -m baro

VOLUME [ "/home/baro/.local/share/Daedalic Entertainment GmbH/Barotrauma" ]
VOLUME /server

# Directory setup
WORKDIR /server
RUN mkdir -p "/home/baro/.local/share/Daedalic Entertainment GmbH/Barotrauma" && chown -R baro:baro /server /home/baro

# Install dependencies
RUN apt update && \
    apt install --no-install-recommends --no-install-suggests -y iproute2 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Allow anyone to read/write to /home/baro/.steam so any user can run the server
RUN mkdir /home/baro/.steam \
    && chown baro:baro /home/baro/.steam \
    && chmod 777 /home/baro/.steam
    
# Add files
COPY --chmod=755 --chown=baro:baro splash.txt entrypoint.sh /

# De-elevate
USER baro

HEALTHCHECK --interval=10s --start-period=10s --retries=3 CMD if [ $(ss -l | grep -c LISTEN.*27015) == "0" ] ; then exit 1; fi
ENTRYPOINT [ "/entrypoint.sh" ]
