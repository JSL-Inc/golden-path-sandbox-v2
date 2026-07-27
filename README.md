# Golden Path Sandbox v2

Runnable demonstration repository generated from `golden-path-template-v2`.

## Included controls

- COUNTRY branch flow: `main → release → feature → develop`
- Pull requests for `develop → feature → release → main`
- Hotfix flow: `main → hotfix → main → release → feature`
- JUnit XML test evidence
- Cobertura XML line coverage
- Blocking 80% coverage baseline with an approved transition mode
- Tests before build for fail-fast feedback
- Blocking build and code-quality checks
- Optional CodeQL and dependency review, plus Dependabot and secret-protection guidance
- OWASP ZAP DAST against non-production targets
- Build-once artifact promotion through `eint1`–`eint6`, `eqa`, `epreprod`, and `prod`
- Semantic versioning and verified release creation
- Production verification and rollback guidance
- API-ready ruleset and environment specifications

Use this repository to create failing and passing pull requests without changing the reusable-workflow or template sources.

## Quick start

```bash
python -m pip install -r requirements.txt
bash .github/golden-path/unit-test.sh
bash .github/golden-path/build.sh
bash .github/golden-path/lint.sh
```

## Automatic demonstration flow

1. Create `release-eqa-poc-release` from `main`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch.
4. Push application changes; one run creates CI evidence and an immutable artifact.
5. Promote with PRs through `develop → feature → release → main`.
6. Feature validation automatically deploys to its named EINT environment.
7. Release validation automatically deploys the same artifact to EQA, ePreProd, or both. `release-epreprod-*` starts at ePreProd; `release-eqa-*` can continue from EQA to ePreProd when `PROMOTE_EQA_TO_EPREPROD` is `true`.
8. Add exactly one `major`, `minor`, or `patch` label to the PR entering `main`.
9. The merge automatically promotes the release artifact to production, verifies it,
   and creates the matching SemVer tag and GitHub Release.

Normal pushes do not also start a second PR copy of core CI. PR events run only
the policy and optional security workflows.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).
