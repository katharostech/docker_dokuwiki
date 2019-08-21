FROM ubuntu:16.04

# Update Operating System
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get clean

# Install Dependencies ( and busybox for vi )
RUN \
  apt-get install -y \
    busybox \
    nginx \
    php7.0 \
    php7.0-gd \
    php7.0-ldap \
    php7.0-sqlite3 \
    php7.0-xml \
    php7.0-zip \
    wget && \
  apt-get clean

# Make an alias for vi
RUN echo "alias vi='busybox vi'" >> /root/.bashrc

# Download Dokuwiki
RUN \
  cd /var/www/html && \
  wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
  tar -xf dokuwiki-stable.tgz && \
  rm dokuwiki-stable.tgz && \
  mv dokuwiki-*/* . && \
  rm -rf dokuwiki-*/ && \
  chown -R www-data .

# Copy in our nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Remove the default nginx configuration
RUN rm /etc/nginx/sites-enabled/default

# Add our nginx configuration
COPY dokuwiki-site /etc/nginx/sites-enabled/dokuwiki-site

# Add our php configuration
COPY php.ini /etc/php/7.0/fpm/php.ini

# Make the PHP run dir
RUN mkdir -p /run/php

# Copy in our container-start and container-start scripts
COPY start-container.sh /start-container.sh
RUN chmod 744 /start-container.sh

COPY stop-container.sh /stop-container.sh
RUN chmod 744 /stop-container.sh

# Copy in our docker-cmd script
COPY docker-cmd.sh /docker-cmd.sh
RUN chmod 744 /docker-cmd.sh

# Set the Docker command
CMD ["/docker-cmd.sh"]
