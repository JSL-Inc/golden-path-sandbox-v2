#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports/junit reports/coverage
python -m pytest tests \
  --junitxml=reports/junit/results.xml \
  --cov=calculator \
  --cov-report=xml:reports/coverage/cobertura.xml
