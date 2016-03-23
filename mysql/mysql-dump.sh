#!/bin/bash

if [ -f "$1" ]; then
    echo "File already exists."
    exit
fi

touch $1

docker run \
	--rm \
	--read-only \
	--link mysql \
	-v $1:/dump.sql \
	mysql:5.6 \
	/bin/bash -c "mysqldump -h mysql -u root -p\${MYSQL_ENV_MYSQL_ROOT_PASSWORD} ${2} > /dump.sql"
