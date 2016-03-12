#!/bin/bash

IMAGE=$1

if [ -z "$IMAGE" ]; then
	echo "missing image name or id"
	exit
fi

docker run \
	-ti \
	--rm \
	--read-only \
	-v ${PWD}/lynis/:/lynis:ro \
	-w /lynis \
	-u root:root \
	--tmpfs=/var/log \
	--tmpfs=/tmp \
	--entrypoint="./lynis" \
	"$IMAGE" \
	--no-log audit system
