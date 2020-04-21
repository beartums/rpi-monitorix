#!/bin/bash

if [ ! -z "$MONITORIX_PORT" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/port = 8080/port = $MONITORIX_PORT/g" $MONITORIX_CONF
  sed -i -e "s/:8080/:$MONITORIX_PORT/g" $MONITORIX_CONF
fi

if [ ! -z "$HOSTNAME" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/hostname = hostname/hostname = $HOSTNAME/g" $MONITORIX_CONF
fi

if [ ! -z "$TITLE" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/title = title/title = $TITLE/g" $MONITORIX_CONF
fi

if [ ! -z "$REFRESH_RATE" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/refresh_rate = 150/refresh_rate = $REFRESH_RATE/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_TOP" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/logo_top = logo_top.png/logo_top = $LOGO_TOP/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_BOTTOM" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/logo_bottom = logo_bot.png/logo_bottom = $LOGO_BOTTOM/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_TOP_URL" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s:logo_top_url = http://www.monitorix.org/:logo_top_url = $LOGO_TOP_URL:g" $MONITORIX_CONF
fi

if [ ! -z "$FAVICON" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
  sed -i -e "s/favicon = monitorixico.png/favicon = $FAVICON/g" $MONITORIX_CONF
fi

cp /assets/* /var/lib/monitorix/www/
