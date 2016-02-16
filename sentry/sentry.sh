#!/bin/bash -e

if [ ! -f ./sentry.env ]; then
	echo "SENTRY_SECRET_KEY=$(docker run --rm -it debian:jessie cat /proc/sys/kernel/random/uuid)" > sentry.env
	docker-compose up -d redis postgres
	sleep 3
	docker-compose run --rm sentry sentry upgrade
fi

docker-compose up -d
