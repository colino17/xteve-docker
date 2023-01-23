FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic

# BASICS
RUN apk update
RUN apk upgrade
RUN apk add --no-cache ca-certificates

# TIMEZONE
RUN apk update && apk add --no-cache tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# ASSORTED DEPENDENCIES
RUN apk add --no-cache curl bash busybox-suid su-exec

# VOLUMES
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve
VOLUME /playlists
VOLUME /xmltv

# FFMPEG AND VLC
RUN apk add ffmpeg
RUN apk add vlc
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

# XTEVE
RUN wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip

# PERMISSIONS
RUN chmod +x /usr/bin/xteve

# PORTS
EXPOSE 34400

# ENTRYPOINT
ENTRYPOINT ["xteve -port=34400 -config=/config"]
