#!/usr/bin/env bash
set -euo pipefail

python -m compileall -q calculator.py
mkdir -p dist
tar -czf dist/application-source.tgz calculator.py requirements.txt
sha256sum dist/application-source.tgz > dist/application-source.tgz.sha256
