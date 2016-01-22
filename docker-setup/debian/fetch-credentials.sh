#!/bin/bash

set -e
if [ "$#" -gt 0 ]; then
  SSH_TO="$1"
else
  echo " => USAGE: ./fetch-credentials.sh <ssh-host> <="
  exit 1
fi

CERT_DIR=/var/docker

scp ${SSH_TO}:${CERT_DIR}/ca.pem ${SSH_TO}:${CERT_DIR}/cert.pem .
echo get key.pem
ssh ${SSH_TO} "/bin/bash -c \"sudo cat /${CERT_DIR}/key.pem\"" > key.pem
chmod u+w ca.pem cert.pem key.pem
