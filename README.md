# Monitorix in docker for Raspberry Pi

Monitorix is a free, open source, lightweight system monitoring tool designed to monitor as many services and system resources as possible.

*Based on the project by jpdus/rpi-monitorix*

*This container enables you to start a monitoring webinterface on your Raspberry Pi in seconds without any configuration.*

## Quickstart

```docker pull jpdus/rpi-monitorix```

```docker run --name monitorix --net host -e MONITORIX_PORT=8080 -d jpdus/rpi-monitorix```

Afterwards just visit 
*http://yourip:8080/monitorix*
for statistics.

## Source

- *[Dockerfile](https://github.com/jpdus/rpi-monitorix/blob/master/Dockerfile)*

- *[Source Repo](https://github.com/jpdus/rpi-monitorix)*

## Other

Instead of --net host you can also map a port:

```docker run --name monitorix -p 8080:8080 -d jpdus/rpi-monitorix```


More information on [Monitorix](http://www.monitorix.org/).

Based on:
[docker-monitorix](https://github.com/yofreke/docker-monitorix)
