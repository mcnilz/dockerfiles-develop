#!/bin/bash -e

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

TIME=`date +%s`
TMPVOL="duply-run-tmp-$TIME"
CNTNAME="duply-run-$TIME"

docker volume create --name="$TMPVOL"

docker run \
	--env="TMPDIR=/tmp" \
	--volume="$TMPVOL:/tmp" \
	--read-only \
	--tmpfs="/root/.gnupg" \
	--volume="duply-archive-keep-and-share:/root/.cache/" \
	--hostname duply \
	--volume="${WORKDIR}:/root/.duply" \
	--volume="${MOUNT}:/mnt" \
	--tty \
	--interactive \
	--name="$CNTNAME" \
	duply $CMD $PARAM

docker rm "$CNTNAME"
docker volume rm "$TMPVOL"
