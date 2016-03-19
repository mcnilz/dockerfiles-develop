#!/bin/bash -e

IP=`sudo ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

docker pull rancher/server

docker run -d \
	--name rancher-server \
	--restart=always \
	-p ${IP}:8999:8080 \
	-v rancher-mysql-data:/var/lib/mysql \
	rancher/server

echo "http://${IP}:8999"
