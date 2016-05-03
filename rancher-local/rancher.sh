#!/bin/bash -e

TAG=stable

if [ -n "$1" ]; then
	TAG=$1
fi

IMAGE="rancher/server:${TAG}"
CONTAINER="rancher-server"

echo "Image: $IMAGE"

IP=`sudo ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

docker pull $IMAGE

set +e
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
set -e

if [ "$RUNNING" == "true" ]; then
	echo Stopping container...
	docker stop -t 1 ${CONTAINER}
fi

set +e
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
set -e

if [ "$RUNNING" == "false" ]; then
	echo Removing container...
	docker rm ${CONTAINER}
fi

docker run -d \
	--name $CONTAINER \
	--restart=always \
	-p ${IP}:8999:8080 \
	-v rancher-mysql-data:/var/lib/mysql \
	$IMAGE

echo "http://${IP}:8999"
