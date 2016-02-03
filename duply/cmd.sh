#!/bin/bash

WORKDIR=$1
MOUNT=$2
CMD=$3
PARAM=${@:4}

if [ -z "$WORKDIR" ]; then
	echo "missing 1st parameter with workdir (/root/.duply)"
	exit 1
fi

if [ -z "$MOUNT" ]; then
	echo "missing 2nd parameter with mount dir (/mnt)"
	exit 1
fi

if [ -z "$CMD" ]; then
	echo "missing 3rd parameter with command [gpg-init | duply-init | duply-run | duply | cmd]"
	exit 1
fi

docker run -h duply -v "${WORKDIR}":/root/.duply -v "${MOUNT}":/mnt --rm -ti duply $CMD $PARAM
