#!/bin/bash

# LATEST UPDATE (01/06/2026)
# DCP-APR-06: Formalised manual Docker deployment workflow for portfolio-site.

set -euo pipefail

APP_NAME="portfolio-site"
REPO_DIR="/var/www/portfolio-site"
BUILD_DIR="$HOME/portfolio-build"
PORT_BINDING="127.0.0.1:8080:80"
IMAGE_TAG="${APP_NAME}:$(date +%Y%m%d-%H%M%S)"

echo "DCP-APR-06 deployment starting"
echo "Image tag: ${IMAGE_TAG}"

echo "Step 1: Update live repository"
cd "$REPO_DIR"
git pull origin main

echo "Step 2: Prepare clean build directory"
rm -rf "$BUILD_DIR"
cp -R "$REPO_DIR" "$BUILD_DIR"

echo "Step 3: Build Docker image"
cd "$BUILD_DIR"
sudo docker build --no-cache -t "$IMAGE_TAG" .

echo "Step 4: Replace running container"
sudo docker stop "$APP_NAME" || true
sudo docker rm "$APP_NAME" || true

sudo docker run -d \
  --name "$APP_NAME" \
  --restart unless-stopped \
  -p "$PORT_BINDING" \
  "$IMAGE_TAG"

echo "Step 5: Validate nginx config"
sudo nginx -t

echo "Step 6: Reload nginx"
sudo systemctl reload nginx

echo "Deployment complete"
echo "Deployed image: ${IMAGE_TAG}"
echo "Run validation next:"
echo "  ./scripts/validate.sh"
