# Rehearsal links and verified results

Start with [the seven-minute presenter guide](DEMO.md).

| Open this | Verified result |
|---|---|
| [Quality evidence ready — PR #69](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/69) | Draft, unmerged. CI and artifact preview passed. Promotion check intentionally stops at missing delivery evidence. |
| [Required evidence missing — PR #70](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/70) | Draft, unmerged. Tests passed; Validate test reports failed because JUnit was removed. |
| [Ready CI run](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40776655212) | Standard CI and Artifact integration evidence succeeded. External Artifactory and Azure were not run. |
| [Missing-evidence CI run](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40776659470) | Failed at the expected report-validation step. |
| [Delivery checkpoint](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40776654962) | Failed because no successful INT Gate exists for this PR commit. |
| [Current release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084) | Active on release-*; CI and Promotion Gate required; zero reviews; owner bypass present. |
| [Shared adapter tests](https://github.com/JSL-Inc/golden-path-workflows-v2/actions/runs/40776175178) | Ten tests passed. Transport tests are in-memory, not live Artifactory tests. |

## Branches

- [Demo base](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/release-eqa-demo-quality-20261028)
- [Ready feature](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/feature-eint1-f91028)
- [Missing evidence feature](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/feature-eint2-f91029)
- [Shared workflow demo](https://github.com/JSL-Inc/golden-path-workflows-v2/tree/demo/quality-artifactory-20261028)
- [Artifactory adapter scope](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/demo/quality-artifactory-20261028/docs/demo-notes.md)

For a live interaction, rerun the ready CI or repair the missing-evidence branch as described in the guide. Leave both PRs unmerged. If a new run is queued, present the verified run linked above.
