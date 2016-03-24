#!/bin/bash

docker pull dockerui/dockerui

docker run \
	--detach \
	--restart=always \
	--privileged \
	--volume="/var/run/docker.sock:/var/run/docker.sock" \
	--name="dockerui" \
	$@ \
	dockerui/dockerui

# port 9000
