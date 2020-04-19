# Monitorix in docker for Raspberry Pi

Monitorix is a free, open source, lightweight system monitoring tool designed to monitor as many services and system resources as possible.

*Based on the project by jpdus/rpi-monitorix*

*This container enables you to start a monitoring webinterface on your Raspberry Pi in seconds without any configuration.*

## Quickstart

```docker pull beartums/rpi-monitorix```

```docker run --name monitorix -p 8080:8080 --device=/dev/vchiq -d beartums/rpi-monitorix```

Afterwards just visit 
*http://yourip:8080/monitorix*
for statistics.

## Source

- *[Dockerfile](https://github.com/jpdus/rpi-monitorix/blob/master/Dockerfile)*

- *[Source Repo](https://github.com/beartums/rpi-monitorix)*

## docker-compose

```
version: "2"
services:
  monitorix:
    image: beartums/rpi-monitorix
    container_name: monitorix
    devices:
      - /dev/vchiq:/dev/vchiq
    ports:
      - 8080:8080
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - <path_to_custom_monitoris.conf_file>:/etc/monitorix/conf.d
    restart: unless-stopped
```


More information on [Monitorix](http://www.monitorix.org/).

Based on:
[docker-monitorix](https://github.com/yofreke/docker-monitorix)
