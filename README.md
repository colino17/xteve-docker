# WHAT IS IT?

A docker container running XTEVE. The XTEVE webui can be accessed via http://XIP:34400/web.

# COMPOSE

```
version: '3'
services:
  xteve:
    container_name: xteve
    image: ghcr.io/colino17/xteve-docker:latest
    restart: unless-stopped
    volumes:
      - /path/to/config:/config
      - /path/to/tmp:/tmp/xteve
      - /path/to/extras:/playlists
      - /path/to/extras:/xmltv
      - /path/to/logos:/logos
    environment:
      - TZ=yourtimezone
    ports:
      - 34400:34400
```

# CREDITS AND SOURCES

- https://github.com/xteve-project/xTeVe
- https://github.com/alturismo/xteve
