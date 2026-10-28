# Seven-minute Golden Path rehearsal

Start with [the prepared links](DEMO-LINKS.md). Open the tabs before presenting;
do not wait for a whole pipeline or merge branches during the demo.

This branch starts at `v1.0.5a`, commit
`286454eab509ee63641890a2ea5cd31289e8f5bf`. That personal version is closest to
the recent ACA implementation inspected. Original branches and settings are unchanged.

## Presenter sequence

| Time | Screen/action | What to get across |
|---|---|---|
| 0:00–0:30 | Quality evidence ready PR | “The earlier demo showed the branch and promotion flow. Today I'm focusing on quality evidence, governance, and the artifact integration work.” |
| 0:30–1:45 | Ready CI summary; optionally Re-run all jobs | “The shared workflow runs the checks and keeps their reports. A successful check needs evidence that can be reviewed.” Use the completed run while the rerun starts. |
| 1:45–2:45 | Missing-evidence PR → Validate test reports | “The unit tests still pass, but the required report is absent. The pipeline catches that missing evidence.” No need to replay branch naming. |
| 2:45–3:45 | Release ruleset → ready PR's Promotion Gate | “Checks provide results; rules determine which results are needed to merge. Passing CI does not supply environment-delivery evidence.” Show the deliberate stop before INT delivery. |
| 3:45–5:45 | Artifact integration evidence summary and metadata | “The Artifactory integration shape is package, identify the tested commit, publish, and retrieve the same output.” Inspect the package/metadata. Explicitly read the external result: preview says Not run; only a real completed round trip says Passed. |
| 5:45–6:30 | Original quality diagram, or mapping below | “This connects quality requirements to actual checks, retained evidence, and points where progression is controlled.” Use the diagram's exact wording. |
| 6:30–7:00 | ACA reference caller, only if helpful | “Work has also gone into ACA through ACR as the primary container path. End-to-end deployment validation is still in progress.” Stop there. |

For five minutes, combine the first two CI examples into one minute and connect
the diagram while showing the ruleset. Keep the Artifactory explanation.

## Optional live edit, without merging

The missing-evidence PR changes only `scripts/unit-test.sh`: it deletes the
JUnit report after successful tests. Edit that file on `feature-eint2-f91029`,
remove the final two demo-only lines, and commit to that branch. CI reruns;
the Promotion Gate still stops delivery. Do not merge. If queued, switch to
the prepared successful PR and return to the new run at the end.

## Connection to quality phases

| Discussion area | Actual evidence |
|---|---|
| Change/PR controls | Source/target checks and the current release ruleset |
| Build quality | Build, tests, lint, coverage, required JUnit/Cobertura reports |
| Artifact handling | Local package, tested commit metadata, checksum; external publication/retrieval only if executed |
| Environment qualification | Stop because this commit has no successful INT delivery evidence |
| Release/production | Existing design only; not executed here |

These are discussion areas, not invented labels for the original diagram or
a claim that every quality requirement has been implemented.

## What is existing work versus rehearsal scaffolding

Existing baseline: shared CI, build/test/lint commands, report validation,
80% coverage in the app's test command, package evidence, branch checks,
promotion design, and ACA/ACR scripts/configuration. Do not call all of these new.

Added for this rehearsal: prepared PR cases, isolated triggers, an Artifactory
preview/round-trip helper, and a shortened delivery evidence check that stops
immediately rather than waiting for a deployment. The personal versions inspected
do not contain the enterprise Artifactory code from the supplied comparison.
This new helper reconstructs its generic integration shape; it is not a verified
copy of that implementation and must not be presented as earlier completed work.

GitHub Actions retains preview evidence. That is not an Artifactory upload.
Neither artifact store supplies ACA's image here; the intended image registry is ACR.

## Governance facts to state accurately

The active [release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084)
targets `release-*` and requires `CI / Standard CI` and `Promotion Gate`.
It currently requires **zero approving reviews**, and the repository owner has
an always-bypass entry. Several older rulesets are disabled. These personal
settings do not prove enterprise review policy or independent approval.

The demo base starts with `release-`, so this ruleset applies. The failed required
check is visible; an authorized bypass remains possible. Do not merge, enable
auto-merge, or demonstrate a bypass. No ruleset settings are changed here.

## Optional real Artifactory run

Preview needs no credentials. For a separate demo Artifactory service, configure
variables `DEMO_ARTIFACTORY_URL` (HTTPS base ending in `/artifactory`) and
`DEMO_ARTIFACTORY_REPOSITORY` (existing generic repository), plus Actions secret
`DEMO_ARTIFACTORY_TOKEN` with upload/read permissions limited to that repository.
Do not move enterprise credentials into the public sandbox.

Dispatch `golden-path-ci.yml` with the ready feature branch as ref and
`run_artifactory=true`. It uploads to a run-specific location, retrieves the
package and metadata, and validates identity/checksum. If the UI does not expose
branch dispatch, use the workflow-dispatch API with that ref. A failure remains
failed. Ordinary PR runs always use local preview mode.

The helper's tests use an in-memory transport; they are not live service proof.
Server retention and overwrite policies are separate from checksum validation.
See [shared rehearsal notes](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/demo/quality-artifactory-20261028/docs/demo-notes.md).

## Boundaries

No merge, tag, release, Azure login, deployment, rollback, or DAST scan is
performed by these rehearsal workflows. Original delivery and release-related
callers are retained under `docs/demo-reference/` for inspection. Their presence
is not execution evidence. Shared rehearsal code is pinned to a commit.
