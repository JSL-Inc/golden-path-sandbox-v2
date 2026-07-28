# Golden Path sandbox v2 — simplified version 2

Runnable proof-of-concept application for the simplified Golden Path.

The sandbox intentionally has the same small integration contract as the
application template:

- `ci.sh` creates JUnit, Cobertura, and build artifacts.
- `stage-validate.sh` represents integration and regression validation.
- `deploy.sh`, `smoke-test.sh`, and `production-verify.sh` demonstrate promotion.
- one pull-request workflow and one delivery workflow call centrally managed
  orchestration.
- GitHub rulesets own CodeQL, code quality, and the 80% coverage gate.

## Local check

```bash
bash .github/golden-path/ci.sh
TARGET_BRANCH=release-eqa-demo bash .github/golden-path/stage-validate.sh
```

## Demonstration

1. Create `release-eqa-demo` or `release-epreprod-demo` from
   `simplified-version-2`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch and push a small change.
4. Merge `develop-s34` into the feature branch. The feature artifact deploys to
   `eint1`.
5. Merge the feature branch into the release branch. The `f26` traceability tag
   is created and the artifact deploys to the environment named in the release
   branch.
6. Open the release branch into `simplified-version-2`. The required workflow
   accepts the successful EQA **or** ePreProd deployment without redeploying it.
7. Merge with no version label. The same artifact is promoted to `prod`,
   verified, tagged as `v0.0.<delivery-run-number>`, and published as a GitHub
   Release.
   `main` remains unchanged throughout this branch-only experiment.

See [architecture](docs/architecture.md), [GitHub settings](docs/github-settings.md),
and the detailed [demo](docs/demo.md).
