#!/bin/bash -e

docker run \
	-d \
	--restart=always \
	--name mongo-express \
	--link mongo:mongo \
	--read-only \
	--tmpfs /root/.config:size=128k \
	$@ \
	mongo-express

# some env:
#   ME_CONFIG_MONGODB_AUTH_USERNAME
#   ME_CONFIG_MONGODB_AUTH_PASSWORD
#   more at https://github.com/mongo-express/mongo-express
