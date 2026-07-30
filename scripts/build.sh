#!/usr/bin/env bash
set -euo pipefail

python -m compileall -q testing/calculator.py
mkdir -p dist
tar -czf dist/application-source.tgz testing/calculator.py requirements.txt
sha256sum dist/application-source.tgz > dist/application-source.tgz.sha256
