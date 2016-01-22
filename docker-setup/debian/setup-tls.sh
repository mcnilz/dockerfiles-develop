#!/bin/bash

set -e
if [ "$#" -gt 2 ]; then
  SSH_TO="$1"
  HOST_NAME="$2"
  HOST_IP="$3"
else
  echo " => USAGE: ./setup-tls.sh <ssh-host> <this-machine's-domain-name> <this-machine's-ip> <="
  exit 1
fi

CERT_DIR=/var/docker
TLS_SCRIPT=create-docker-tls.sh

scp ${TLS_SCRIPT} ${SSH_TO}:

echo "create certificates"
ssh ${SSH_TO} "/bin/bash -c \"sudo mkdir -p ${CERT_DIR} && cd ${CERT_DIR} && sudo sh ~/${TLS_SCRIPT} ${HOST_NAME} ${HOST_IP}\""

echo "enable tls in /etc/defaults"
ssh ${SSH_TO} "/bin/bash -c \"echo 'DOCKER_OPTS=\\\"--tlsverify --tlscacert=${CERT_DIR}/ca.pem --tlscert=${CERT_DIR}/server-cert.pem --tlskey=${CERT_DIR}/server-key.pem -H=0.0.0.0:2376\\\"' | sudo tee -a /etc/default/docker\""

echo "enable tls in systemd"
ssh ${SSH_TO} "/bin/bash -c \"sudo mkdir -p /etc/systemd/system/docker.service.d\""
ssh ${SSH_TO} "/bin/bash -c \"echo -e '[Service]\\nExecStart=\\nExecStart=/usr/bin/docker daemon -H fd:// --tlsverify --tlscacert=/var/docker/ca.pem --tlscert=/var/docker/server-cert.pem --tlskey=/var/docker/server-key.pem -H=0.0.0.0:2376' | sudo tee /etc/systemd/system/docker.service.d/tls2.conf && sudo systemctl daemon-reload\""

echo "restart docker service"
ssh ${SSH_TO} "/bin/bash -c \"sudo service docker restart\""

echo "***********************************"
echo "* make sure tcp port 2376 is open *"
echo "***********************************"
