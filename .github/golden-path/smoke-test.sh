#!/usr/bin/env bash
set -euo pipefail

test -d promoted-artifact
test -n "$(find promoted-artifact -type f -print -quit)"
echo "Smoke test passed: promoted artifact is present."
