# DCP-APR-06 Rollback Runbook

LATEST UPDATE (01/06/2026)

## Purpose

This runbook defines how to recover from a failed deployment.

This stage uses Docker image rollback only.

Git rollback is intentionally out of scope.

## Rollback Philosophy

A deployment is only safe if there is a known recovery path.

Every deployment creates a uniquely tagged Docker image.

Older images remain available for rollback.

## List Available Images

Run:

sudo docker images portfolio-site

Example output:

portfolio-site   20260601-203500
portfolio-site   20260601-201200

## Rollback Procedure

Run:

cd ~/portfolio-infra

./scripts/rollback.sh portfolio-site:<previous-image-tag>

Example:

./scripts/rollback.sh portfolio-site:20260601-201200

After rollback:

./scripts/validate.sh

## What rollback.sh Does

1. Confirms the requested image exists.
2. Stops the current container.
3. Removes the current container.
4. Starts a new container from the previous image.
5. Tests nginx configuration.
6. Reloads nginx.

## Failure Points

Requested image does not exist.

Docker daemon is unavailable.

Container fails to start.

nginx configuration validation fails.

## Success Criteria

Rollback is successful only when:

./scripts/rollback.sh <image>

completes successfully and:

./scripts/validate.sh

passes.

## Operational Rule

Do not remove old Docker images unless you intentionally want to lose rollback capability.
