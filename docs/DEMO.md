# Seven-minute Golden Path rehearsal: CI → CD → controlled progression

Start with [the prepared links](DEMO-LINKS.md). Open the successful CI run, the
Golden Path CD graph, the release ruleset, and the artifact evidence before presenting.
Keep completed runs open so the demo does not depend on finishing every merge.

The base is `v1.0.5a` (`286454eab509ee63641890a2ea5cd31289e8f5bf`).
Both `golden-path-ci.yml` and `golden-path-cd.yml` are active in this rehearsal.
Original branches and repository settings are unchanged.

## Presenter sequence

| Time | Screen/action | High-level explanation |
|---|---|---|
| 0:00–0:30 | Ready PR and workflow files | “The previous demo covered the branch/promotion flow. This time I'll follow the output from CI into CD, show the artifact integration work, and connect the checkpoints to quality governance.” |
| 0:30–1:15 | Completed CI summary | “The shared CI workflow builds, checks, and keeps the output and test evidence.” Don't repeat the full unit-test/branch-naming demonstration. |
| 1:15–3:15 | **Golden Path CD run graph** | “CD selects the target environment, requires successful CI for this same change, and retrieves that CI output.” Open Determine Delivery Plan, CI Success Gate, and Resolve Validated Artifact. These are real jobs from the reusable CD implementation. |
| 3:15–4:45 | Artifact integration evidence and Artifactory helper | “The Artifactory integration shape is package, identify the source, publish, and retrieve the output.” Show the actual local package/metadata and distinguish preview from any real service run. This rehearsal's CD retrieves from GitHub Actions; it is not an Artifactory download. |
| 4:45–6:15 | Release ruleset, Promotion Gate and original quality diagram | “CI evidence, environment qualification, and merge requirements are separate checkpoints.” Connect the checks to the original diagram using its exact phase names. Show why the PR is not qualified for promotion merely because CI passed. |
| 6:15–7:00 | CD's explicit stop, then ACA caller/configuration briefly | “I've also worked on ACA through ACR as the primary container delivery path. End-to-end validation is still in progress. Here, deployment and later tests are deliberately not run.” |

For five minutes, use 30 seconds for CI, 90 seconds for CD, 90 seconds for
Artifactory, and one minute for governance, with a brief opening and ACA update.
The missing-report example is optional background, not the main storyline.

## What Golden Path CD really runs

The active caller invokes the actual `reusable-standard-cd.yml`, pinned to a
commit. The rehearsal adds one input, `execute_delivery: false`, so the existing
route, exact-commit CI lookup, download, and artifact validation run. Deployment,
environment tests, INT/QA/ePreProd gates, production verification, and release
creation are skipped. Their original implementation remains visible in the graph.

A final review job explicitly stops the run with a failure annotation. This is
an expected rehearsal boundary, not an Azure failure. The CD run must not become
successful environment-delivery evidence. The separate required Promotion Gate
continues to fail because no real successful INT Gate exists for this commit.

This rehearsal consumes the package its CI actually produces. It does not invent
a container descriptor or an ACR image. The original ACA caller, retained in
`docs/demo-reference/golden-path-cd.yml`, uses the container/ACA configuration.
Changing to real ACA delivery requires a real container artifact and service configuration.

## Optional live interaction

Rerun Golden Path CD on the ready feature branch from the prepared run's menu;
its existing CI run supplies the same-commit artifact. While it runs, show the
completed CD graph and ruleset. No merge is needed.

Alternatively repair the missing-evidence PR: remove the final two demo-only
lines from `scripts/unit-test.sh` on `feature-eint2-f91029` and commit there.
CI and CD rerun. CI must produce the report before CD can retrieve its output.
The actual deployment and the promotion qualification remain stopped.
Use the prepared ready runs if the new jobs are still queued. Leave both PRs unmerged.

## Connection to quality phases

| Discussion area | Actual evidence |
|---|---|
| Change/PR controls | Source/target checks and the current release ruleset |
| Build quality | Real build/test/lint results and JUnit/Cobertura files |
| CI-to-CD handoff | Same-commit CI success, target selection, and real artifact retrieval |
| Artifact integration | Local package/metadata/checksum; external Artifactory only if a real round trip was run |
| Environment qualification | Existing INT/QA/ePreProd checks shown as not run, and promotion remains unqualified |
| Release/production | Existing design visible; not executed |

These areas do not replace the exact labels in the original quality diagram.
The earlier demo already included reusable workflows, governance, and promotion
concepts; do not present all of those as newly introduced.

## Scope and limitations

Added for this rehearsal: prepared PR cases, isolated triggers, the explicit
CD execution switch/review stop, the Artifactory preview/round-trip adapter,
and this guide. They are rehearsal scaffolding, not earlier completed enterprise work.

The personal versions inspected do not contain the enterprise Artifactory code
shown in the supplied comparison. The new helper reconstructs its generic shape;
it is not a verified copy. The normal run says **external Artifactory: Not run**.
GitHub Actions stores the preview evidence, and CD retrieves the CI package from
GitHub Actions. ACR remains the intended registry for ACA images.

## Governance facts

The active [release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084)
targets `release-*` and requires `CI / Standard CI` plus `Promotion Gate`.
It currently requires **zero approving reviews** and permits owner bypass.
Several older rulesets are disabled. State those personal settings accurately;
they do not prove enterprise approval policy. The demo base is covered by the
release rule. No ruleset settings were changed. Do not merge or use bypass.

## Optional real Artifactory run

For a separate demo service, configure variables `DEMO_ARTIFACTORY_URL`
(HTTPS base ending in `/artifactory`) and `DEMO_ARTIFACTORY_REPOSITORY`,
plus secret `DEMO_ARTIFACTORY_TOKEN` with upload/read access.
Dispatch `golden-path-ci.yml` on the ready branch with `run_artifactory=true`.
Only a completed real upload/download/checksum verification proves that service
round trip. Ordinary PR runs are local previews. A real Artifactory run does not
change the demonstrated CD package provider or prove ACA deployment.
The helper tests use in-memory transport and do not prove live service access.
