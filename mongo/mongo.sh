#!/bin/bash -e

docker run \
	-d \
	--restart=always \
	--name mongo \
	--volume mongo-data-db:/data/db \
	--volume mongo-configdb:/data/configdb \
	$@ \
	mongo:3.2
