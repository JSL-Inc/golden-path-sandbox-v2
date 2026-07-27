#!/usr/bin/env bash
set -euo pipefail

mkdir -p reports/regression
python -m pytest tests -v | tee reports/regression/results.txt
