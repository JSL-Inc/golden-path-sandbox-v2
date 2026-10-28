#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports/junit reports/coverage
python -m pytest testing \
  --junitxml=reports/junit/results.xml \
  --cov=testing.calculator \
  --cov-fail-under=80 \
  --cov-report=xml:reports/coverage/cobertura.xml

# DEMO ONLY: remove the required evidence after passing tests; delete these two lines to repair.
rm reports/junit/results.xml
