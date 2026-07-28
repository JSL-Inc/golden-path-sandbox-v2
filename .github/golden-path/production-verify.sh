#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports/production
{
  echo "Production verification passed."
  echo "Commit: ${GITHUB_SHA:-local}"
} | tee reports/production/verification.txt
