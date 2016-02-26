#!/bin/bash -e

if [ ! -f ./mysql.env ]; then
	echo "MYSQL_ROOT_PASSWORD=$(docker run --rm -it debian:jessie cat /proc/sys/kernel/random/uuid)" > ./mysql.env
fi

docker run \
	-d \
	--restart=always \
	--name mysql \
	--env-file ./mysql.env \
	--volume mysql-data:/var/lib/mysql \
	$@ \
	mysql:5.6
