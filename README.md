# Monitorix in docker for Raspberry Pi

Monitorix is a free, open source, lightweight system monitoring tool designed to monitor as many services and system resources as possible.

This container is a work in progress.  Many of the graphs available are not appropriate for a RPi, and some of them don't currently work in the docker container.  Some of the ones I find most useful are: _system, raspberrypi, kern, proc, process_ and _net_.  I'll be adding more environment variables for controlling the configuration over time (probably).  Feel free to log an issue if you need something and I'll get to it if I can.

*Based on the project [jpdus/rpi-monitorix](https://github.com/jpdus/rpi-monitorix)*

*This container enables you to start a monitoring webinterface on your Raspberry Pi in seconds*

## Quickstart

```docker pull beartums/rpi-monitorix```

```docker run --name monitorix -p 8080:8080 --device=/dev/vchiq -d beartums/rpi-monitorix```

Afterwards just visit 
*http://yourip:8080/monitorix*
for statistics.

## Configuration

### Using environment variables
  Several environment variables are supported for configuring the docker container:
  | ENV | Default | Purpose |
  |---|---|---|
  | TITLE || page title
  | MONITORIX_HOSTNAME || name at the top of the graph page |
  | REFRESH_RATE| (150) | seconds between page refreshes |
  | TEMPERATURE_SCALE| (c) | c(elsius) or f(ahrenheit) |
  | HTTPD-GROUP| (nobody) | linux user group name to run the http server under |
  | FAVICON| (monitorix.png) | name and path to a png favicon for the page |
  | LOGO_TOP| (logo-top.png) | name and path of a logo to display at the tope of the landing page |
  | LOGO_TOP_URL| (https://www.monitorix.com) | URL to send someone clicking on the logo a thte top of the landing page |
  | LOGO_BOTTOM| (logo-bot.png) | name and path to a logo to display at the bottom of the graphs page |
  | GRAPHS || list of the graphs to enable on the page in the order that you want to see them* |
  * if you don't define it, the GRAPHS list uses monitorix defaults (though only some are enabled by default, and some don't work for the raspberry pi), which is: system, raspberrypi, kern, proc, hptemp, lmsens, gensens, ipmi, ambsens, nvidia, disk, fs, zfs, du, net, netstat, tc, libvirt, process, serv, mail, port, user, ftp, apache, nginx, lighttpd, mysql, mongodb, varnish, pagespeed, squid, nfss, nfsc, bind, unbound, ntp, chrony, fail2ban, icecast, phpapc, memcached, phpfpm, apcupsd, nut, wowza, int, verlihub

  _Not Currently Supported_
   - MULTIHOST_ENABLED
   - REMOTEHOST_LIST
   - REMOTEHOST_DESC
   - MULTIHOST_GROUPS
   - REMOTEGROUP_LIST
   - ENABLE_HOURLY_VIEW
   - ENABLE_BACK_BUTTON

### Using a Configuration File
  Add a volume to a location with a *.conf file, and monitorix will use that .conf (or multiple .confs) to update the default configuration file ([found here](https://github.com/mikaku/Monitorix/blob/master/monitorix.conf)).  You can use this method if you need to set some values that are not handled by the environment variables.  But be aware that if you use environment variables _and_ the config file, the results might be unexpected

## Docker Compose

```
  monitorix:
    image: beartums/rpi-monitorix:latest
    container_name: monitorix
    devices:
      - /dev/vchiq:/dev/vchiq
    environment:
      - MONITORIX_HOSTNAME=Media Servers
      - TITLE=Media Server Status
      - REFRESH_RATE=150
      - TEMPERATURE_SCALE=f
      - HTTPD-GROUP=www-data
      # - ENABLE_HOURLY_VIEW=n
      # - ENABLE_BACK_BUTTON=n
      - FAVICON=monitoringico.png
      - LOGO_TOP=griffith-logo.png
      - LOGO_TOP_URL=http://192.168.0.25:8080/monitorix
      - LOGO_BOTTOM=griffith-logo.png
      - GRAPHS=system,raspberrypi,kern,proc,process,int,serv,net
      # - MULTIHOST_ENABLED=
      # - REMOTEHOST_LIST=
      # - REMOTEHOST_DESC=
      # - MULTIHOST_GROUPS=y
      # - REMOTEGROUP_LIST=
      # - REMOTEGOUP_DESC=
    ports:
      - 8080:8080
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /path/to/directory/with/.conf/file/:/etc/monitorix/conf.d
      - /path/to/folder/containing/assets/to/copy/to/www-root/:/assets      
    restart: unless-stopped
```

## Source

- *[Dockerfile](https://github.com/jpdus/rpi-monitorix/blob/master/Dockerfile)*

- *[Source Repo](https://github.com/beartums/rpi-monitorix)*


More information on [Monitorix](http://www.monitorix.org/).

Based on:
[rpi-monitorix](https://github.com/jpdus/rpi-monitorix)

Which, in turn, is based on:
[docker-monitorix](https://github.com/yofreke/docker-monitorix)
