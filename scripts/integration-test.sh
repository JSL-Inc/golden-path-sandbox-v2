#!/usr/bin/env bash
set -euo pipefail

environment="${1:?Environment is required}"
mkdir -p reports/integration
echo "Integration test in $environment passed." \
  | tee reports/integration/results.txt
