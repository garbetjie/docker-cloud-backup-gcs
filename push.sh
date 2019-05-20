#!/usr/bin/env bash

set -e

# Extract the current version.
version="$(git describe --always)"

# Confirm version.
printf "About to push version \`${version}\`. Is this correct? [Y/n] "
read confirm

if [[ "$confirm" = "N" ]] || [[ "$confirm" = "n" ]]; then
	exit 0
fi

# Build latest Docker image.
docker build -t garbetjie/cloud-backup:gcs-latest .

# Build the versioned image.
docker tag garbetjie/cloud-backup:gcs-latest garbetjie/cloud-backup:gcs-$version

# Push images.
docker push garbetjie/cloud-backup:gcs-latest
docker push garbetjie/cloud-backup:gcs-$version