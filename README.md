# Dokuwiki Docker Image

[![Build Status](https://cloud.drone.io/api/badges/katharostech/docker_dokuwiki/status.svg)](https://cloud.drone.io/katharostech/docker_dokuwiki)

This is a simple Docker image for the free and open source Dokuwiki. It is built on top of Ubuntu and is running PHP 7 and Nginx.

Dokuwiki is so simple to install that I have found no need for having environment variables for configuration. Everything can be done through the Dokuwiki UI as far as I am aware. :)

If you want to persist your install and/or configuration, the important paths are:

* The configuration directory: `/var/www/html/conf`
* The data directory ( where your wiki pages go ): `/var/www/html/data`

## Example Run Command

```bash
docker run --name dokuwiki \
-p 80:80 \
-e MAX_UPLOAD_SIZE=10M \
-v wiki-data:/var/www/html/data \
-v wiki-conf:/var/www/html/conf \
katharostech/dokuwiki
```
