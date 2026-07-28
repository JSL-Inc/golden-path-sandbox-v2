#!/usr/bin/env bash
set -euo pipefail

test -d "${ARTIFACT_DIRECTORY:?Artifact directory is required}"
find "$ARTIFACT_DIRECTORY" -maxdepth 2 -type f -print
echo "POC deployment adapter completed."
echo "This POC promotes the immutable GitHub Actions artifact locally."
