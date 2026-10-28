# Golden Path demo — September format, updated

Follow the September outline: repository orientation, prepared success
walkthrough, one live PR interaction, and one failure/governance example.
The September demo never happened; compare redundancy against the last
actual demonstration, rather than treating the September plan as already shown.

Start with [prepared PRs and runs](DEMO-LINKS.md).

## Seven-minute sequence

| Time | Section | What to show and explain |
|---|---|---|
| 0:00–0:45 | Overall | Briefly show the application callers and central CI/CD workflows. Explain ownership without touring every file. |
| 0:45–2:45 | Prepared success walkthrough | Explain develop → feature/INT → release/QA and optional ePreProd using completed evidence. Keep Golden Path CD central: environment selection, same-commit CI gate, artifact retrieval, then downstream qualification. Show later stages as configured rather than executed where evidence is absent. |
| 2:45–4:15 | Artifactory addition | Show the actual work integration configuration and service evidence if available. Explain identification and downstream retrieval. The personal rehearsal has only a local preview; label it. ACR remains the intended ACA image registry. |
| 4:15–5:45 | Live PR interaction | Inspect PR #69 and mark the prepared draft ready for review, or rerun CI. Show the resulting checks and feedback. Keep completed results available while jobs queue. Leave it unmerged. |
| 5:45–7:00 | One failure and governance | Show one relevant failed check and its effect on the required results/ruleset. PR #70 is an explicitly staged missing-report example; an actual regression failure from work is also useful if its run is available. Connect this to the original quality diagram. |
| 7:00–7:15 | Status | Briefly acknowledge work toward ACA through ACR as the primary container path; end-to-end validation remains in progress. |

For five minutes, shorten orientation and the prepared branch walkthrough.
Keep CD, Artifactory, PR/governance feedback, and the status statement.
Multiple failure cases, feature tagging, and historical releases are backup tabs.

## Keep the September event matrix

Use this to navigate, not as a list of newly delivered capabilities.

| Stage | Push/prepared evidence | PR results | Post-merge progression |
|---|---|---|---|
| Develop → feature | Build/test CI | Applicable CI, warning-period feedback, policy results | Feature environment and INT qualification |
| Feature → release | Prior evidence for the same change | Applicable CI/security results and required promotion results | QA, optional ePreProd, feature tag if configured |
| Release → main | Validated release candidate | Release requirements and SemVer label | Production/release path; do not claim execution without a real run |

Check the actual current event and result on every example. The September
outline includes Golden Path Warning Period and CodeQL; they are not wired
into the new personal rehearsal branch. Use a real current work PR/run to
demonstrate them, or state their status. The local artifact preview is not
a replacement for that warning workflow or a security scan.

## Prepared evidence versus live interaction

- PR #69 has real CI and CD handoff evidence. CD's plan, same-commit CI gate,
  and artifact retrieval passed. Deployment and qualification gates did not run.
- The final artificial CD stop is a rehearsal boundary, not the product-failure
  example to spend time demonstrating.
- PR #70 deliberately removes a required report after tests pass. It can be
  repaired live without a merge. Show only one failure example.
- Historical releases and tags do not prove the current chain works end to end.
- Use the original quality diagram's exact phase names when connecting checks,
  evidence, and enforcement; do not invent labels.

Prepared post-merge runs carry the progression so the live segment does not
depend on a chain of merges. The earlier actual demo already covered some
branching, governance, and reusable workflow concepts; keep those brief.

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
