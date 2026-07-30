# Golden Path Sandbox v2

Runnable demonstration application for the centralized golden-path proof of
concept. The files in `.github/workflows` are thin event callers; the reusable
jobs and gates are maintained in
`JSL-Inc/golden-path-workflows-v2`.

## Included controls

- COUNTRY branch flow: `main → release → feature → develop`
- Pull requests for `develop → feature → release → main`
- Automatic `f###` traceability tag when a feature PR merges into a release branch
- Hotfix flow: `main → hotfix → main → release → feature`
- JUnit XML test evidence
- Cobertura XML line coverage
- Blocking 80% coverage baseline with an approved transition mode
- Architecture-aligned build, testing, deployment, and gate order
- Blocking build and code-quality checks
- GitHub-native CodeQL, code-quality, coverage, dependency, and secret controls
  enforced through repository settings and rulesets
- OWASP ZAP DAST against non-production targets
- Build-once artifact promotion through `eint1`–`eint6`, `eqa`, `epreprod`, and `prod`
- Semantic versioning and verified release creation
- Production verification and rollback guidance
- API-ready ruleset and environment specifications

The calculator function is demonstration application code. Pipeline adoption
does not require changing that function; the workflow contract is implemented
by the files in `scripts`, `testing`, `.zap`, and `.github`.

## Quick start

```bash
python -m pip install -r requirements.txt
bash scripts/unit-test.sh
bash scripts/build.sh
ruff check testing
```

## Automatic demonstration flow

1. Create `release-eqa-poc-release` from `main`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch.
4. Push application changes; the branch pipeline creates test evidence and an artifact.
5. Promote with PRs through `develop → feature → release → main`.
6. Merging `feature-eint1-f26` into the release branch automatically tags that release-branch merge commit as `f26`.
7. Feature validation automatically deploys to its named EINT environment.
8. A `release-eqa-*` branch deploys to EQA. A `release-epreprod-*` branch deploys to EQA first and then promotes the same artifact through ePreProd.
9. Add exactly one `major`, `minor`, or `patch` label to the PR entering `main`.
10. The merge promotes the successful release-branch artifact to production; it does not rebuild it.
11. After production deployment, smoke testing, and verification succeed, the matching SemVer tag and GitHub Release are created automatically.

Normal pushes do not also start a second PR copy of core CI. PR events run only
policy and quality checks. GitHub only discovers workflow callers directly
under `.github/workflows`.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).
