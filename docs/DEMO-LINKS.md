# Demo start page

[Open the full September-format runbook](DEMO.md).

## Open tabs in this order

1. [Application callers](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/release-eqa-demo-quality-20261028/.github/workflows) and [central workflows](https://github.com/JSL-Inc/golden-path-workflows-v2/tree/demo/quality-artifactory-20261028/.github/workflows)
2. [Develop push CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780704658) and [develop to feature PR 71](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/71)
3. [Feature Golden Path CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699635)
4. [Artifact package evidence](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699552) and [Artifactory rehearsal adapter](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/5a44961adfc91267f6a1a868245cf4d6b17d7b27/.github/actions/artifactory-evidence/evidence.py)
5. [Prepared release CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780695963) and [historical release output](https://github.com/JSL-Inc/golden-path-sandbox-v2/releases/tag/v3.1.0)
6. [Create the live PR](https://github.com/JSL-Inc/golden-path-sandbox-v2/compare/release-epreprod-demo-20261028...feature-eint5-f9242?expand=1) — prepared branch, deliberately unopened
7. [Prepared warning comment fallback](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72#issuecomment-6482393831)
8. [Failure PR 73](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73), [failed CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713809), [CD prerequisite failure](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713639)
9. [Current release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084)

## Prepared examples

- [PR 71 develop to feature](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/71): real passing tests, branch checks, and warning comment.
- [PR 72 feature to release](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72): prepared feature CD handoff and promotion checkpoint.
- [PR 73 intentional failure](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73): failing unit test, CI rejected by CD, warning feedback.
- [Live comparison](https://github.com/JSL-Inc/golden-path-sandbox-v2/compare/release-epreprod-demo-20261028...feature-eint5-f9242?expand=1): open this during the demo, or reuse the resulting PR if rehearsed.

All prepared PRs remain draft and unmerged. The stage runs are separate snapshots.
CD planning/CI/artifact jobs passed on the ready snapshots; deployment and later
qualification gates were not run. External Artifactory was not contacted.
The final CD review failure is the explicit rehearsal stop.
