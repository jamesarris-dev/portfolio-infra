#!/bin/bash

# LATEST UPDATE (01/06/2026)
# DCP-APR-06: Added manual rollback to a previous local Docker image.

set -euo pipefail

APP_NAME="portfolio-site"
PORT_BINDING="127.0.0.1:8080:80"

if [ "${1:-}" = "" ]; then
  echo "Usage:"
  echo "  ./scripts/rollback.sh portfolio-site:<previous-image-tag>"
  echo ""
  echo "Available portfolio-site images:"
  sudo docker images "portfolio-site"
  exit 1
fi

ROLLBACK_IMAGE="$1"

echo "Rollback starting"
echo "Rollback image: ${ROLLBACK_IMAGE}"

echo "Step 1: Confirm rollback image exists"
sudo docker image inspect "$ROLLBACK_IMAGE" > /dev/null

echo "Step 2: Stop current container"
sudo docker stop "$APP_NAME" || true
sudo docker rm "$APP_NAME" || true

echo "Step 3: Start previous image"
sudo docker run -d \
  --name "$APP_NAME" \
  --restart unless-stopped \
  -p "$PORT_BINDING" \
  "$ROLLBACK_IMAGE"

echo "Step 4: Validate nginx config"
sudo nginx -t

echo "Step 5: Reload nginx"
sudo systemctl reload nginx

echo "Rollback complete"
echo "Run validation next:"
echo "  ./scripts/validate.sh"
