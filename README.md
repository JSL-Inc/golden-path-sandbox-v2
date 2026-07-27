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
- CodeQL, dependency review, Dependabot, and secret-protection guidance
- OWASP ZAP DAST against non-production targets
- Build-once artifact promotion through Integration, QA, Preproduction, and Production
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

## Branch demonstration

1. Create `release-eqa-poc-release` from `main`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch.
4. Open a PR from `develop-s34` to `feature-eint1-f26`.
5. Promote feature to release and release to main using PRs.
6. Run the release workflow with exactly one `major`, `minor`, or `patch` classification.
7. Promote the same artifact through protected environments.
8. Verify production before creating the official GitHub Release.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).
