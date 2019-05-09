#!/usr/bin/env bash

set -e

# Extract the current version.
version="$(grep FROM Dockerfile | cut -f2 -d: | cut -f1 -d-)"

# Build latest Docker image.
docker build -t garbetjie/backup-gcs:latest .

# Build the versioned image.
docker tag garbetjie/backup-gcs:latest garbetjie/backup-gcs:$version

# Push images.
docker push garbetjie/backup-gcs:latest
docker push garbetjie/backup-gcs:$version