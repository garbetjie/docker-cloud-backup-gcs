#!/usr/bin/env bash

# Ensure we exit on any failure.
set -e

# Ensure we have a project.
if [[ "$CLOUDSDK_CORE_PROJECT" = "" ]]; then
	echo "CLOUDSDK_CORE_PROJECT environment variable is required, and should contain the ID of the project to copy files to."
	exit 1
fi

# Ensure we have a service account, and that it is a file that exists.
if [[ "$GOOGLE_APPLICATION_CREDENTIALS" = "" ]] || [[ ! -f "$GOOGLE_APPLICATION_CREDENTIALS" ]]; then
	echo "GOOGLE_APPLICATION_CREDENTIALS cannot be empty, and must point to a file containing service account credentials."
	exit 1
fi

# Ensure we have a bucket defined.
if [[ "$BUCKET_NAME" = "" ]]; then
	echo "BUCKET_NAME must be defined, and must be the name of the bucket to copy files into."
	exit 1
fi

# Authenticate the service account.
gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"

set -x

# Build up extra/additional arguments.
extra_args=()
[[ "$DELETE" = "true" ]] && extra_args+=("-d")
[[ "$DRY_RUN" = "true" ]] && extra_args+=("-n")
[[ "$EXCLUDE" != "" ]] && extra_args+=("-x" "${EXCLUDE}")

# Run the command.
exec gsutil -o "GSUtil:parallel_thread_count=16" rsync -R -c "${extra_args[@]}" /mnt/ "gs://${BUCKET_NAME}/${BUCKET_PATH#/}"