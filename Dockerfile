FROM alpine:latest

# S6 OVERLAY
ARG S6_OVERLAY_VERSION=3.1.3.0
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# ENVIRONMENT
ENV TZ=Canada/Atlantic
ENV PUID=1000
ENV PGID=1000

# BASICS
RUN apk upgrade --update --no-cache \
    && apk add --no-cache \
    ca-certificates \
    curl \
    tzdata \
    bash \
    coreutils \
    shadow \
    ffmpeg \
    vlc \
    gnutls-utils

# TIMEZONE
RUN apk update && apk add --no-cache tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# XTEVE
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip
ADD logos /logos

# USER
RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /home/abc -s /bin/bash abc && \
    usermod -G users abc

# VOLUMES
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve
VOLUME /playlists
VOLUME /xmltv
VOLUME /logos

# PERMISSIONS
RUN chmod +x /usr/bin/xteve

# PORTS
EXPOSE 34400

# ENTRYPOINT
ENTRYPOINT ["/init"]
CMD ["xteve -port=34400 -config=/root/.xteve/"]
