#!/bin/bash -e

IP=`ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

docker run -d \
	--name rancher-server \
	--restart=always \
	-p ${IP}:8999:8080 \
	rancher/server

echo "http://${IP}:8999"
