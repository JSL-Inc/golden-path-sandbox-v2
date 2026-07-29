# New deploy POC

This branch demonstrates the repository-local version of the Golden Path. It
uses readable workflow YAML and small scripts rather than central reusable
workflow callers.

## Files

- `new-deploy.yml` runs CI, creates the artifact once, and deploys it to the
  non-production environment selected by the branch name.
- `pr-policy.yml` enforces `develop → feature → release → main`.
- `pr-semver.yml` requires one `major`, `minor`, or `patch` label before a
  release or hotfix can enter the production branch.
- `feature-id-tag.yml` creates the `f###` traceability tag after a feature is
  merged into a release branch.
- `release.yml` promotes the validated release-branch artifact to `prod`,
  verifies it, and creates the SemVer tag and GitHub Release.
- `security.yml` runs local CodeQL and dependency review jobs.
- `dast.yml` provides an optional manual OWASP ZAP scan against a
  non-production URL.

## Branch behavior

| Branch | Automated behavior |
|---|---|
| `develop-*` | Unit tests, 80% coverage, lint, build, artifact |
| `feature-eint1-f###` through `feature-eint6-f###` | CI, deploy to matching EINT, smoke and integration tests |
| `release-eqa-*` / `hotfix-eqa-*` | CI, deploy to EQA, smoke, integration, regression |
| `release-epreprod-*` / `hotfix-epreprod-*` | CI, deploy to ePreProd, smoke, integration, regression |
| `main` | Production is owned only by `release.yml` after a release/hotfix PR merge |

The test deployment scripts intentionally print passing POC results. They are
adapter points for application-specific deployment and test commands later.

## Required repository settings

Create `eint1`–`eint6`, `eqa`, `epreprod`, and `prod` Environments. Protect the
shared and production Environments with the appropriate reviewers and prevent
self-review for production.

Use these stable required status checks:

- `Pull Request Policy / Branch Flow`
- `Branch Delivery Pipeline / Promotion Gate`
- For `main` only: `PR SemVer Label Check / Release Label`

Do not configure `main` to require an EQA or production deployment directly.
The release branch's Promotion Gate proves the selected EQA or ePreProd stage,
and production starts only after the release/hotfix PR is merged.

Secret scanning, push protection, Dependabot, required reviewers, and rulesets
are GitHub repository or organization settings rather than workflow code.
