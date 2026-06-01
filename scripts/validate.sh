#!/bin/bash

# LATEST UPDATE (01/06/2026)
# DCP-APR-06: Added manual deployment validation checks for portfolio-site.

set -euo pipefail

APP_NAME="portfolio-site"
DOMAIN="https://jamesarris.dev"

echo "DCP-APR-06 validation starting"

echo "Check 1: Docker container exists and is running"
sudo docker ps --filter "name=${APP_NAME}" --filter "status=running"

echo "Check 2: Local container responds on 127.0.0.1:8080"
curl -I http://127.0.0.1:8080

echo "Check 3: nginx config is valid"
sudo nginx -t

echo "Check 4: nginx service is active"
sudo systemctl is-active nginx

echo "Check 5: Public HTTPS endpoint responds"
curl -I "$DOMAIN"

echo "Check 6: Page content contains expected title text"
curl -s "$DOMAIN" | grep -i "James Arris"

echo "Validation complete"
