#!/bin/bash

# modified https://gist.githubusercontent.com/hermanjunge/7d4f416f77b2ff1fbfb5/raw/c29e4ab6e623653d8c02b8bae0d34e3dedb81798/create-docker-tls.sh

###############################################################################
#
# This script will help you setup Docker for TLS authentication.
# Run it passing in the argument for the FQDN of your docker server
# And the ip of your machine
#
# Script execution example
#    ./create-docker-tls.sh myhost.docker.com 192.168.99.100
#
#
# Test examples
#
# Run docker daemon
#
# sudo docker daemon --tlsverify --tlscacert=/home/hermanjunge/.docker/ca.pem --tlscert=/home/hermanjunge/.docker/server-cert.pem --tlskey=/home/hermanjunge/.docker/server-key.pem -H=0.0.0.0:2376
#
# Execute a client call
#
# docker --tlsverify --tlscacert=/home/hermanjunge/.docker/ca.pem --tlscert=/home/hermanjunge/.docker/cert.pem --tlskey=/home/hermanjunge/.docker/key.pem -H=192.168.99.100:2376 version
#
###############################################################################


set -e
if [ "$#" -gt 1 ]; then
  HOST_NAME="$1"
  HOST_IP="$2"
else
  echo " => USAGE: ./create-docker-tls <this-machine's-domain-name> <this-machine's-ip> <="
  exit 1
fi

echo " => Using Hostname: $HOST_NAME. You MUST connect to docker using this host!"


###############################################################################
#
# Temp passphrase
#
###############################################################################


echo " => Generating temp passphrase"
openssl rand \
  -base64 32 \
  > tmp.passphrase


###############################################################################
#
# Certificate Authority
#
###############################################################################


echo " => Generating CA key"
openssl genrsa \
  -aes256 \
  -out ca-key.pem \
  -passout file:tmp.passphrase \
  4096

# For reasons I have yet to learn and understand well,
# We need to include in the subject the Organization.
# In other words, the organization cannot go blank.
echo " => Generating CA certificate"
openssl req \
  -new \
  -x509 \
  -days 365 \
  -key ca-key.pem \
  -sha256 \
  -passin file:tmp.passphrase \
  -subj "/O=$HOST_NAME/CN=$HOST_NAME" \
  -out ca.pem


###############################################################################
#
# Server Key
#
###############################################################################


echo " => Generating server key"
openssl genrsa \
  -out server-key.pem \
  4096

echo " => Generating server CSR"
openssl req \
  -subj "/CN=$HOST_NAME" \
  -sha256 \
  -new \
  -key server-key.pem \
  -out server.csr

echo " => Creating extended key usage"
echo subjectAltName = IP:$HOST_IP > extfile.cnf

echo " => Signing server CSR with CA"
openssl x509 \
  -req \
  -days 365 \
  -sha256 \
  -in server.csr \
  -CA ca.pem \
  -CAkey ca-key.pem \
  -CAcreateserial \
  -passin file:tmp.passphrase \
  -extfile extfile.cnf \
  -out server-cert.pem


###############################################################################
#
# Client Key
#
###############################################################################


echo " => Generating client key"
openssl genrsa \
  -out key.pem \
  4096

echo " => Generating client CSR"
openssl req \
  -subj '/CN=client' \
  -new \
  -key key.pem \
  -out client.csr

echo " => Creating extended key usage"
echo extendedKeyUsage = clientAuth > extfile.cnf

echo " => Signing client CSR with CA"
openssl x509 \
  -req \
  -days 365 \
  -sha256 \
  -in client.csr \
  -CA ca.pem \
  -CAkey ca-key.pem \
  -CAcreateserial \
  -passin file:tmp.passphrase \
  -extfile extfile.cnf \
  -out cert.pem


###############################################################################
#
# Cleanup
#
###############################################################################

rm tmp.passphrase
rm -v client.csr server.csr ca.srl extfile.cnf
chmod -v 0400 ca-key.pem key.pem server-key.pem
chmod -v 0444 ca.pem server-cert.pem cert.pem
