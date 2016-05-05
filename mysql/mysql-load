#!/bin/bash

docker run \
	--rm \
	--read-only \
	--link mysql \
	-v $1:/dump.sql:ro \
	mysql:5.6 \
	/bin/bash -c "cat /dump.sql | mysql -h mysql -u root -p\${MYSQL_ENV_MYSQL_ROOT_PASSWORD} ${2}"
