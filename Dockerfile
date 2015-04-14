FROM resin/rpi-raspbian:wheezy
MAINTAINER Jan Harries <jph@jph.me>

RUN apt-get update

# Install dependencies
RUN apt-get install -yq rrdtool perl libwww-perl libmailtools-perl libmime-lite-perl librrds-perl libdbi-perl libxml-simple-perl libhttp-server-simple-perl libconfig-general-perl libio-socket-ssl-perl

# Download the deb
RUN apt-get install -y wget nano
RUN wget http://www.monitorix.org/monitorix_3.7.0-izzy1_all.deb && \
    dpkg -i monitorix*.deb

# Add the launch script
ADD launch.sh /launch.sh
RUN chmod +x /launch.sh

# Run launch script to modify port
CMD sh /launch.sh

# Restart monitorix service and read logs to be able to run the container in background
CMD service monitorix restart && tail -F /var/log/monitorix
