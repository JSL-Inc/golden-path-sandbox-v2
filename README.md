# Golden Path Sandbox v2

Runnable demonstration repository generated from `golden-path-template-v2`.

The `new-deploy-stuff-template` branch demonstrates the organization-ready
template and is temporarily treated like `main`. See
[the organization template demo](docs/organization-template-demo.md).

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
8. Release validation always passes EQA. Branches named `release-epreprod-*`
   then promote the same artifact through ePreProd before production.
9. Add exactly one `major`, `minor`, or `patch` label to the PR entering `main`.
10. The merge runs the production deployment and smoke test.
11. After that production pipeline succeeds, the matching SemVer tag and GitHub
    Release are created without deploying production a second time.

Normal pushes do not also start a second PR copy of core CI. PR events run only
the policy and optional security workflows.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).
