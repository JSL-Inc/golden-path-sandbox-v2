# Demo links — CI and CD

Start with the [revised seven-minute presenter guide](DEMO.md). The main
walkthrough follows CI output into the active Golden Path CD workflow.

| Open this | Verified result |
|---|---|
| [Ready PR #69](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/69) | Draft and unmerged; both CI and CD callers present. |
| [Golden Path CD run — main demo screen](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40778665614) | Delivery plan, same-commit CI gate, and artifact retrieval/validation passed. Final review intentionally stops; deployment and qualification gates skipped. |
| [Matching push CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40778665797) | Successful source of CD's actual package; same feature commit. |
| [Active CD caller](../.github/workflows/golden-path-cd.yml) | Invokes the real reusable CD implementation with rehearsal-only execute_delivery=false. |
| [Shared CD implementation](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/a5648a400d82708dbecb5221a532714e9d3a078d/.github/workflows/reusable-standard-cd.yml) | Actual route/CI/artifact logic retained; deployment and downstream gates explicitly disabled for review. |
| [Current release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084) | CI and Promotion Gate required; zero reviews and owner bypass currently configured. |
| [Optional missing-evidence PR #70](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/70) | Tests pass but required report is removed; CI fails. |
| [Missing-evidence CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40778671886) | Failed as expected at report validation. |
| [Missing-evidence CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40778670314) | Fails its CI prerequisite; cannot use a validated artifact. |
| [Earlier artifact preview](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40776655212) | Local package/metadata/checksum evidence; external Artifactory was not run. |

The ready CI and CD runs use source commit
`db1b00b1993a15a16835dbd07cc4b872c05dcad3`.
The ready CD's overall failure is the explicit rehearsal stop, not an Azure
failure. Do not describe it as a successful environment delivery. The
Promotion Gate still requires a real successful INT Gate.

## Branches

- [Demo base](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/release-eqa-demo-quality-20261028)
- [Ready feature](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/feature-eint1-f91028)
- [Missing evidence feature](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/feature-eint2-f91029)
- [Shared workflow demo](https://github.com/JSL-Inc/golden-path-workflows-v2/tree/demo/quality-artifactory-20261028)

Re-run the prepared CD run for a live interaction without merging. Keep the
completed graph open while it runs. The guide explains the Artifactory
preview limitation and the brief ACA/ACR progress update.
