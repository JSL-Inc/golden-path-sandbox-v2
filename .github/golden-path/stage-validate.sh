#!/usr/bin/env bash
set -euo pipefail

target="${TARGET_BRANCH:?TARGET_BRANCH is required}"
mkdir -p reports/stage

# Replace this POC assertion with the approved Robot Framework integration
# suite when the Testing Center of Excellence contract is available.
python - <<'PY' | tee reports/stage/integration.txt
from calculator import add

assert add(10, 5) == 15
print("Integration validation passed.")
PY

case "$target" in
  prerelease-*|release-*|hotfix-*)
    python -m pytest tests -v | tee reports/stage/regression.txt
    ;;
  feature-*)
    echo "Regression is not required for a dedicated feature environment." \
      | tee reports/stage/regression.txt
    ;;
  *)
    echo "No additional regression suite is required for $target." \
      | tee reports/stage/regression.txt
    ;;
esac
