# Golden-path repository setup

## Central workflow repository

`JSL-Inc/golden-path-workflows-v2` contains reusable orchestration only:

```text
.github/
└── workflows/
    ├── branch-validation.yml
    ├── code-coverage.yml
    ├── feature-tagging.yml
    ├── new-deploy.yml
    ├── owasp-zap-scan.yml
    ├── pr-flow.yml
    ├── pr-semver-check.yml
    └── release.yml
docs/
└── usage.md
README.md
```

## Application/template repository

Application repositories receive the following contract. Workflow files are
thin callers and must be directly inside `.github/workflows`.

```text
.github/
├── CODEOWNERS
├── ISSUE_TEMPLATE/
│   └── control-exception.yml
├── PULL_REQUEST_TEMPLATE.md
├── dependabot.yml
└── workflows/
    ├── branch-validation.yml
    ├── code-coverage.yml
    ├── feature-tagging.yml
    ├── new-deploy.yml
    ├── owasp-zap-scan.yml
    ├── pr-flow.yml
    ├── pr-semver-check.yml
    └── release.yml
.zap/
└── rules.tsv
docs/
governance/
├── environments.json
├── labels.json
├── settings.md
└── rulesets/
    ├── feature-prerelease.json
    ├── main.json
    ├── release.json
    └── tags.json
scripts/
├── build.sh
├── deploy.sh
├── integration-test.sh
├── regression-test.sh
├── smoke-test.sh
└── unit-test.sh
testing/
├── calculator.py
└── test_calculator.py
.gitignore
README.md
requirements.txt
testing.txt
```

Real applications replace the sample implementation and script commands while
preserving the documented inputs and evidence paths.

## Bootstrap checklist

1. Create the eight callers from the template.
2. Create labels `major`, `minor`, and `patch`.
3. Create environments `eint1` through `eint6`, `eqa`, `epreprod`, and `prod`.
4. Configure each environment's deployment branch patterns from
   `governance/environments.json`.
5. Apply the repository rulesets described in `governance/settings.md`.
6. Enable secret scanning and push protection.
7. Enable CodeQL default setup and GitHub Code Quality/coverage where licensed.
8. Replace the POC CODEOWNERS user with approved organization teams.
9. Protect `.zap/rules.tsv` with an AppSec CODEOWNER.
