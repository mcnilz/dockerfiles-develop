#!/bin/bash

GID=`id -g $USER`

docker run -u "$UID:$GID" -ti --rm -v ${PWD}/:/work -w /work --link mongo mongo mongodump --host=mongo $@
