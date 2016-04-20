#!/bin/bash

# https://docs.docker.com/engine/reference/commandline/events/
# https://docs.docker.com/engine/userguide/labels-custom-metadata/

while read line ; do
	CONTAINER=`echo $line | awk '{print $4}'`
	echo "CONTAINER: $CONTAINER"
	DB_NAME=`docker inspect -f '{{ index .Config.Labels "mysql.db.name" }}' $CONTAINER`
	DB_USERNAME=`docker inspect -f '{{ index .Config.Labels "mysql.db.username" }}' $CONTAINER`
	DB_PASSWORD=`docker inspect -f '{{ index .Config.Labels "mysql.db.password" }}' $CONTAINER`
	echo "DB NAME: $DB_NAME"
	# TODO CREATE DB
done < <(docker events --filter "event=start" --filter "label=mysql.db.name")
