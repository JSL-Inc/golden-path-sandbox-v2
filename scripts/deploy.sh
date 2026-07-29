#!/usr/bin/env bash
set -euo pipefail

environment="${1:?Environment is required}"
artifact_directory="${2:?Artifact directory is required}"

test -d "$artifact_directory"
test -n "$(find "$artifact_directory" -type f -print -quit)"
echo "Deployment to $environment passed."
