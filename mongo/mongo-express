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

# exposed port 8081:
#   -p 127.0.0.1:8081:8081
# some env:
#   -e ME_CONFIG_MONGODB_AUTH_USERNAME=admin
#   -e ME_CONFIG_MONGODB_AUTH_PASSWORD=pass
#   more at https://github.com/mongo-express/mongo-express
