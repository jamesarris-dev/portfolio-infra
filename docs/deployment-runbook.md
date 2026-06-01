# DCP-APR-06 Deployment Runbook

LATEST UPDATE (01/06/2026)

## Purpose

This runbook defines the manual Docker deployment workflow for jamesarris.dev.

The goal is repeatability, validation, and operational discipline.

This stage does not introduce CI/CD.

## Current Architecture

Internet
→ Cloudflare DNS
→ AWS Lightsail
→ host nginx
→ Certbot HTTPS termination
→ proxy_pass 127.0.0.1:8080
→ Docker container
→ container nginx
→ static portfolio site

## Deployment Location

Deployment is performed on the AWS Lightsail server.

Site repository:

/var/www/portfolio-site

Infrastructure repository:

~/portfolio-infra

## Deployment Command

Run on the server:

cd ~/portfolio-infra
./scripts/deploy.sh
./scripts/validate.sh

## What deploy.sh Does

1. Pulls the latest site code from GitHub.
2. Copies /var/www/portfolio-site into ~/portfolio-build.
3. Builds a new timestamped Docker image.
4. Stops and removes the old portfolio-site container.
5. Starts a new portfolio-site container bound to 127.0.0.1:8080.
6. Tests nginx config.
7. Reloads nginx.

## Main Failure Points

git pull can fail if the server repo has uncommitted changes.

Docker build can fail if the Dockerfile or build context is broken.

Container startup can fail if port 8080 is already in use.

nginx -t can fail if the nginx config is invalid.

Public HTTPS validation can fail if nginx, Docker, DNS, Cloudflare, or the server is unhealthy.

## Validation

Deployment is not complete until this passes:

./scripts/validate.sh

Validation checks:

- Docker container is running.
- Container responds on 127.0.0.1:8080.
- nginx config is valid.
- nginx service is active.
- Public HTTPS endpoint responds.
- Page contains expected James Arris title text.

## Operational Rule

Do not casually prune Docker images.

Old portfolio-site images are rollback targets.
