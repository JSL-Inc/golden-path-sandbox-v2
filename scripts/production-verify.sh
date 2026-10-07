#!/usr/bin/env bash
set -euo pipefail
url="${1:?Production URL is required}"
curl --fail --silent --show-error --retry 5 --retry-delay 3 --max-time 10 "${url%/}/health" >/dev/null
echo "Production health check passed."
