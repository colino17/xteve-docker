FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic

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
    gnutls-utils

# TIMEZONE
RUN apk update && apk add --no-cache tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# XTEVE
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip
ADD logos /logos
ADD scripts /scripts
ADD sample.conf /

# VOLUMES
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve
VOLUME /playlists
VOLUME /xmltv
VOLUME /logos

# PERMISSIONS
RUN chmod +x /usr/bin/xteve
RUN chmod +x /scripts/xteve.sh

# PORTS
EXPOSE 34400

# ENTRYPOINT
ENTRYPOINT ["./scripts/xteve.sh"]
