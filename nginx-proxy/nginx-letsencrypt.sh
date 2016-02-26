#!/bin/bash

docker run \
	-d \
	--restart=always \
	--name nginx-proxy \
	--volume /var/run/docker.sock:/tmp/docker.sock:ro \
	--volume nginx-proxy-certs:/etc/nginx/certs:rw \
	--volume nginx-proxy-vhost:/etc/nginx/vhost.d \
	--volume nginx-proxy-html:/usr/share/nginx/html \
	-p 80:80 \
	-p 443:443 \
	$@ \
	jrcs/letsencrypt-nginx-proxy-companion
