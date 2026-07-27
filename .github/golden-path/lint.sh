#!/usr/bin/env bash
set -euo pipefail

ruff check calculator.py tests
ruff format --check calculator.py tests
