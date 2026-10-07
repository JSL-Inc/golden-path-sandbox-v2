#!/usr/bin/env bash
set -euo pipefail

environment="${1:?Environment is required}"
application_url="${2:?Application URL is required}"
curl --fail --silent --show-error --retry 5 --retry-delay 3 --max-time 10 \
  "${application_url%/}/health" >/dev/null
echo "Smoke test in $environment passed."
