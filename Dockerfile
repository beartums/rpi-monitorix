  
FROM balenalib/rpi-raspbian:latest

RUN apt-get update

# Install dependencies
RUN apt-get install -yq rrdtool perl libwww-perl libmailtools-perl \
        libmime-lite-perl librrds-perl libdbi-perl libxml-simple-perl \
        libhttp-server-simple-perl libconfig-general-perl libio-socket-ssl-perl

# Download the deb
RUN apt-get install -y wget nano libraspberrypi-bin
RUN wget https://www.monitorix.org/monitorix_3.12.0-izzy1_all.deb && \
    dpkg -i monitorix*.deb && \
    rm monitorix_3.12.0-izzy1_all.deb

# Add the default overrides file
ADD monitorix.conf /etc/monitorix/conf.d

# Add the launch script
ADD launch.sh /launch.sh
RUN chmod +x /launch.sh

# Restart monitorix service and read logs to be able to run the container in background
CMD sh /launch.sh && service monitorix restart && tail -F /var/log/monitorix
