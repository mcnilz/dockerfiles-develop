#!/bin/bash

set -e
if [ "$#" -gt 0 ]; then
  SSH_TO="$1"
else
  echo " => USAGE: ./setup-docker.sh <ssh-host> <="
  exit 1
fi

ssh ${SSH_TO} "/bin/bash -c \"curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker \${USER}\""
