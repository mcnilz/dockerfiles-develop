#!/bin/bash

docker run \
	-d \
	--restart=always \
	--name nginx-letsencrypt \
	--volume /var/run/docker.sock:/var/run/docker.sock:ro \
	--volume nginx-proxy-certs:/etc/nginx/certs:rw \
	--volume nginx-proxy-vhost:/etc/nginx/vhost.d \
	--volume nginx-proxy-html:/usr/share/nginx/html \
	-e NGINX_PROXY_CONTAINER=nginx-proxy \
	-p 80:80 \
	-p 443:443 \
	$@ \
	jrcs/letsencrypt-nginx-proxy-companion
