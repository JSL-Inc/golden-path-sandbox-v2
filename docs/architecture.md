# Application architecture

This repository contains application code and only the adapters needed by the
centrally managed Golden Path.

- `pull-request.yml` is the POC caller for the centrally required PR workflow.
- `delivery.yml` sends branch pushes and feature merges to one reusable delivery
  workflow.
- `dast.yml` is optional and manual.
- `.github/golden-path/` contains the five commands that vary by application.

Organization rulesets and security settings are intentionally not stored here.
The template does not manually duplicate CodeQL, Code Quality, secret scanning,
push protection, or the 80% coverage gate.
