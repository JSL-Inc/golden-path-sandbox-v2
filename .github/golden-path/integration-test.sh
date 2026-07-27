#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports/integration
python - <<'PY'
from calculator import add
assert add(10, 5) == 15
PY
echo "Integration test passed." > reports/integration/results.txt
