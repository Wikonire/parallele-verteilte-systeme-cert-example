#!/bin/bash
# Skript zur Erstellung eines RSA-Schlüsselpaars

docker run --rm -v "$(pwd)/certs:/certs" alpine/openssl genrsa -out /certs/private.key 2048
docker run --rm -v "$(pwd)/certs:/certs" alpine/openssl rsa -in /certs/private.key -pubout -out /certs/public.key

echo "Schlüssel generiert: certs/private.key und certs/public.key"
