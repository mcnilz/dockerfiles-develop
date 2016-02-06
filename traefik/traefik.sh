#!/bin/bash

docker run -d -p 127.0.0.1:8080:8080 -p 127.0.0.1:80:80 \
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-v $PWD/traefik.toml:/traefik.toml:ro \
	--name traefik \
	--restart always \
	emilevauge/traefik