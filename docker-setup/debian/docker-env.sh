#!/bin/bash

set -e
if [ "$#" -gt 0 ]; then
  HOST="$1"
else
  echo " => USAGE: ./docker-env.sh <host> <="
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Keys in $DIR"
echo "Host: $HOST"

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://$HOST:2376"
export DOCKER_CERT_PATH="$DIR"
