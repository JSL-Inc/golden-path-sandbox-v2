#!/usr/bin/env bash
set -euo pipefail

# This is the only stack-specific CI contract required by the central workflow.
python -m pip install -r requirements.txt

mkdir -p reports/junit reports/coverage dist

# Fail fast on unit-test failures and emit the enterprise report formats.
python -m pytest tests \
  --junitxml=reports/junit/results.xml \
  --cov=calculator \
  --cov-report=xml:reports/coverage/cobertura.xml

# Stack-specific deterministic quality checks remain part of CI. GitHub Code
# Quality and the organization ruleset provide the additional native gate.
ruff check calculator.py tests
ruff format --check calculator.py tests

python -m compileall -q calculator.py
tar -czf dist/application-source.tgz calculator.py requirements.txt
sha256sum dist/application-source.tgz > dist/application-source.tgz.sha256
