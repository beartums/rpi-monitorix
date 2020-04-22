#!/bin/bash
if [ -z "$MONITORIX_CONF" ]; then
  MONITORIX_CONF="/etc/monitorix/monitorix.conf"
fi

if [ ! -z "$MONITORIX_PORT" ]; then
  sed -i -e "s/port = 8080/port = $MONITORIX_PORT/g" $MONITORIX_CONF
  sed -i -e "s/:8080/:$MONITORIX_PORT/g" $MONITORIX_CONF
fi

if [ ! -z "$MONITORIX_HOSTNAME" ]; then
  sed -i -e "1,/<graph_enable>/{s/\(\s*\)\(hostname\s*=\s*.*\)$/\1hostname = $MONITORIX_HOSTNAME/g}" $MONITORIX_CONF
fi

if [ ! -z "$TITLE" ]; then
  sed -i -e "1,/<graph_enable>/{s/\(\s*\)\(title\s*=\s*.*\)$/\title = $TITLE/g}" $MONITORIX_CONF
fi

if [ ! -z "$REFRESH_RATE" ]; then
  sed -i -e "s/refresh_rate = 150/refresh_rate = $REFRESH_RATE/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_TOP" ]; then
  sed -i -e "s/logo_top = logo_top.png/logo_top = $LOGO_TOP/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_BOTTOM" ]; then
  sed -i -e "s/logo_bottom = logo_bot.png/logo_bottom = $LOGO_BOTTOM/g" $MONITORIX_CONF
fi

if [ ! -z "$LOGO_TOP_URL" ]; then
  sed -i -e "s|logo_top_url = http://www.monitorix.org/|logo_top_url = $LOGO_TOP_URL|g" $MONITORIX_CONF
fi

if [ ! -z "$FAVICON" ]; then
  sed -i -e "s/favicon = monitorixico.png/favicon = $FAVICON/g" $MONITORIX_CONF
fi

# copy the assets in the assets folder to the www folder, if any
[ -d "/assets/" ] && cp /assets/* /var/lib/monitorix/www/

if [ ! -z "$ENABLED_GRAPHS" ]; then
  IFS=',' read -r -a GRAPHS <<< "$ENABLED_GRAPHS"
  START='<graph_enable>'
  END='<\/graph_enable>'
  FIND='n'
  REPLACE='y'
  for GRAPH in "${GRAPHS[@]}"
  do
    echo $GRAPH
    sed -i "/$START/,/$END/{s/\(\s*$GRAPH\s*=\s*\)[\s$FIND]*$/\1$REPLACE/g}" $MONITORIX_CONF
  done
fi

if [ ! -z "$DISABLED_GRAPHS" ]; then
  IFS=',' read -r -a GRAPHS <<< "$DISABLED_GRAPHS"
  START='<graph_enable>'
  END='<\/graph_enable>'
  FIND='y'
  REPLACE='n'
  for GRAPH in "${GRAPHS[@]}"
  do
    echo $GRAPH
    sed -i "/$START/,/$END/{s/\(\s*$GRAPH\s*=\s*\)[\s$FIND]*$/\1$REPLACE/g}" $MONITORIX_CONF
  done
fi
