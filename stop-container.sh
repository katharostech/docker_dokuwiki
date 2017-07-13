#!/bin/sh

kill -s TERM $(cat /run/php/php7.0-fpm.pid)

# Stop nginx
nginx -s stop
