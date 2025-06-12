#!/bin/bash
# Skript zur Erstellung eines Let's Encrypt Zertifikats (benötigt öffentliche Domain und Port 80 frei!)

DOMAIN="deine-domain.com"
EMAIL="deine-email@domain.com"

docker run -it --rm \
  -v "$(pwd)/certs/letsencrypt:/etc/letsencrypt" \
  -v "$(pwd)/certs/letsencrypt-lib:/var/lib/letsencrypt" \
  certbot/certbot certonly \
  --standalone \
  --non-interactive \
  --agree-tos \
  --email "$EMAIL" \
  -d "$DOMAIN"

echo "Zertifikate erstellt unter certs/letsencrypt/live/$DOMAIN/"
