#!/bin/bash
# Deploy nginx with self-signed cert to remote hosts
set -e

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 user@host [user@host...]" >&2
  exit 1
fi

WORKDIR=$(mktemp -d)

# Generate self-signed certificate
openssl req -newkey rsa:4096 -nodes -keyout "$WORKDIR/nginx.key" \
  -x509 -days 365 -out "$WORKDIR/nginx.crt" -subj "/CN=localhost"

# Create nginx config
cat > "$WORKDIR/nginx.conf" <<'NGINX'
server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/certs/nginx.crt;
    ssl_certificate_key /etc/nginx/certs/nginx.key;

    location / {
        return 200 'Deployed via deploy.sh';
    }
}
NGINX

# Create Dockerfile
cat > "$WORKDIR/Dockerfile" <<'DOCKER'
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.crt /etc/nginx/certs/nginx.crt
COPY nginx.key /etc/nginx/certs/nginx.key
DOCKER

# Create docker-compose file
cat > "$WORKDIR/docker-compose.yml" <<'COMPOSE'
version: "3"
services:
  nginx:
    build: .
    ports:
      - "443:443"
COMPOSE

for host in "$@"; do
  scp -r "$WORKDIR" "$host:/tmp/nginx-deploy"
  ssh "$host" "docker compose -f /tmp/nginx-deploy/docker-compose.yml up -d"
done

echo "Deployment completed."
