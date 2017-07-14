#!/bin/sh

# Start php-fpm
echo "Starting php-fpm"
php-fpm7.0

# Start nginx
echo "Starting nginx"
nginx

nginx_error_log=/var/log/nginx/error.log
nginx_access_log=/var/log/nginx/access.log
php_log=/var/log/php7.0-fpm.log

# Tail the logs, after making sure they esist, for docker logs
while [ ! -f $nginx_error_log ]; do :; done
while [ ! -f $nginx_access_log ]; do :; done
while [ ! -f $php_log ]; do :; done
tail -f $nginx_error_log $nginx_access_log $php_log &
