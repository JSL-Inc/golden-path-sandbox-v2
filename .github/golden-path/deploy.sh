#!/usr/bin/env bash
set -euo pipefail

test -d "${ARTIFACT_DIRECTORY:?Artifact directory is required}"
find "$ARTIFACT_DIRECTORY" -maxdepth 2 -type f -print
echo "POC deployment adapter completed."
echo "Production implementation replaces this step with approved Artifactory/cloud tooling."
