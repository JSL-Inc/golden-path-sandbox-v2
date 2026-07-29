# Golden Path Sandbox v2

Runnable demonstration repository generated from `golden-path-template-v2`.

## Included controls

- COUNTRY branch flow: `main → release → feature → develop`
- Pull requests for `develop → feature → release → main`
- Automatic `f###` traceability tag when a feature PR merges into a release branch
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
bash scripts/unit-test.sh
bash scripts/build.sh
bash scripts/lint.sh
```

## Automatic demonstration flow

1. Create `release-eqa-poc-release` from `main`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch.
4. Push application changes; one run creates CI evidence and an immutable artifact.
5. Promote with PRs through `develop → feature → release → main`.
6. Merging `feature-eint1-f26` into the release branch automatically tags that release-branch merge commit as `f26`.
7. Feature validation automatically deploys to its named EINT environment.
8. Release validation automatically deploys the same artifact to the single shared environment named by the branch: EQA or ePreProd.
9. Add exactly one `major`, `minor`, or `patch` label to the PR entering `main`.
10. The merge automatically promotes the release artifact to production, verifies it,
    and creates the matching SemVer tag and GitHub Release.

Normal pushes do not also start a second PR copy of core CI. PR events run only
the policy and optional security workflows.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).
