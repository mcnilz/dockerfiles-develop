#!/bin/bash

# https://docs.docker.com/engine/reference/commandline/events/
# https://docs.docker.com/engine/userguide/labels-custom-metadata/

while read line ; do
	CONTAINER=`echo $line | awk '{print $4}'`
	CONTAINER_NAME=`docker inspect -f '{{json .Name }}' $CONTAINER 2> /dev/null`
	echo "CONTAINER: $CONTAINER $CONTAINER_NAME"
	DB_NAME=`docker inspect -f '{{ index .Config.Labels "mysql.db.name" }}' $CONTAINER 2> /dev/null`
	DB_USERNAME=`docker inspect -f '{{ index .Config.Labels "mysql.db.username" }}' $CONTAINER 2> /dev/null`
	DB_PASSWORD=`docker inspect -f '{{ index .Config.Labels "mysql.db.password" }}' $CONTAINER 2> /dev/null`
	RUNNING=`docker inspect -f '{{json .State.Running }}' $CONTAINER 2> /dev/null`
	if [ "$RUNNING" == "true" ]; then
		SQL="CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"
		echo "SQL: $SQL"
		echo "$SQL" | mysql -h mysql -u root -p"${MYSQL_ENV_MYSQL_ROOT_PASSWORD}"

		# TODO CREATE USER
	fi
done < <(docker events --filter "event=start" --filter "label=mysql.db.name")
