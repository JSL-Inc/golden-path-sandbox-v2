# New deploy POC

This branch keeps the repository structure and delivery order used by the
architecture diagram. The scripts intentionally return simple passing POC
results and can later be replaced with application-specific commands.

## Workflow responsibilities

| File | Responsibility |
|---|---|
| `branch-validation.yml` | Validates the approved branch naming conventions |
| `code-coverage-v2.yml` | Runs unit tests and enforces the 80% coverage baseline on pull requests |
| `feature-tagging.yml` | Creates the `f###` traceability tag after a feature enters a release branch |
| `new-deploy.yml` | Runs the architecture-ordered build, deployments, tests, and gates |
| `owasp-zap-scan.yml` | Provides an on-demand full ZAP scan for a deployed non-production URL |
| `pr-flow.yml` | Enforces `develop → feature → release → main` |
| `pr-semver-check.yml` | Requires exactly one `major`, `minor`, or `patch` label before production |
| `release.yml` | Waits for successful production delivery and creates the SemVer tag and GitHub Release |

## Architecture order

1. Build and quality checks
   - Build
   - Unit tests
   - Cobertura coverage
   - Code quality
   - GitHub code-scanning result required by the ruleset
2. Deploy to the environment selected by the branch.
3. Run Integration and Regression tests for feature, release, and hotfix branches.
4. Evaluate the INT Gate for feature branches.
5. Run Smoke and DAST policy checks in EQA.
6. Evaluate the QA Gate for release and hotfix branches.
7. For `*-epreprod-*` branches, promote the same artifact to ePreProd, repeat
   the applicable tests, and evaluate the ePreProd Gate.
8. A merge to `main` runs the production deployment and smoke test.
9. `release.yml` waits for that successful production run and then creates the release.

Every release uses EQA. The release or hotfix branch name decides whether
ePreProd is also required.

## Branch behavior

| Branch | Environment | Tests and gate |
|---|---|---|
| `develop-*` | None | Build-time quality checks |
| `feature-eint1-f###` through `feature-eint6-f###` | Matching EINT | Integration, Regression, INT Gate |
| `release-eqa-*` / `hotfix-eqa-*` | EQA | Integration, Regression, Smoke, DAST, QA Gate |
| `release-epreprod-*` / `hotfix-epreprod-*` | EQA, then ePreProd | Integration, Regression, Smoke, DAST policy, QA Gate, ePreProd Gate |
| `main` | Prod | Deployment and Smoke; release follows success |

`new-deploy-stuff` temporarily behaves like `main` so the complete flow can be
tested without changing `main`. Remove that branch from the three workflow
branch lists when copying these files to the work repository.

## Required GitHub settings

Create `eint1`–`eint6`, `eqa`, `epreprod`, and `prod` environments. Configure
the required reviewers on shared and production environments and prevent
self-review where appropriate. The environment approval provides the
PO/business approval point for this POC; a failed test is corrected and rerun.

Use these required status checks:

- `Branch Validation / Branch Name`
- `PR Flow / Branch Flow`
- `Code Coverage / Coverage 80%`
- For `main`: `PR SemVer Check / Release Label`

Use GitHub ruleset settings for required pull requests, approvals, code
scanning results, resolved conversations, and blocked direct pushes. Enable
secret scanning, push protection, and Dependabot in repository or organization
settings.
