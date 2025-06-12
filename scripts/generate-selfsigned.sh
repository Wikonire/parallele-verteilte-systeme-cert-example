#!/bin/bash
# Skript zur Erstellung eines selbstsignierten SSL-Zertifikats

docker run --rm -v "$(pwd)/certs:/certs" alpine/openssl req \
  -x509 -nodes -days 365 \
  -newkey rsa:4096 \
  -keyout /certs/selfsigned.key \
  -out /certs/selfsigned.crt \
  -subj "/CN=localhost"

echo "Self-signed Zertifikat erstellt: certs/selfsigned.crt und certs/selfsigned.key"
