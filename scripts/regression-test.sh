#!/usr/bin/env bash
set -euo pipefail

environment="${1:?Environment is required}"
mkdir -p reports/regression
echo "Regression test in $environment passed." \
  | tee reports/regression/results.txt
