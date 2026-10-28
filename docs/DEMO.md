# Golden Pipeline Demo

Updated presenter materials using the September 24 outline

**Target: seven minutes.** Use the prepared results while live checks queue.

## Branch and workflow table

| Branch | Direct push | PR link | PR workflows and feedback | Post-merge stage reference |
|---|---|---|---|---|
| develop-s9241 | [Golden Path CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780704658) | [develop to feature PR 71](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/71) | [CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780755168)<br>[Warning feedback](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/71) | [Prepared feature CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699635) |
| feature-eint4-f9241 | [Golden Path CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699552) | [feature to release PR 72](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72) | [CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780758741)<br>[Warning comment](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72#issuecomment-6482393831)<br>[Ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084) | [Prepared release CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780696739)<br>[Prepared release CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780695963) |
| release-epreprod-demo-20261028 | [CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780696739)<br>[CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780695963) | [Release status and reference](https://github.com/JSL-Inc/golden-path-sandbox-v2/releases/tag/v3.1.0) | [Shared release logic](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/5a44961adfc91267f6a1a868245cf4d6b17d7b27/.github/workflows/reusable-standard-cd.yml) | [Earlier release output](https://github.com/JSL-Inc/golden-path-sandbox-v2/releases/tag/v3.1.0) |
| feature-eint5-f9242 | [CI ready](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780709701)<br>[CD handoff](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780709663) | [Open live PR](https://github.com/JSL-Inc/golden-path-sandbox-v2/compare/release-epreprod-demo-20261028...feature-eint5-f9242?expand=1) | [Prepared feedback fallback](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72#issuecomment-6482393831) | [Stop before merge](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/feature-eint5-f9242) |
| feature-eint6-f9243 | [Failing CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713809) | [Failure PR 73](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73) | [Failure comment](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73#issuecomment-6482394900) | [CD rejects failed CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713639) |

The stage-reference links are separately prepared snapshots. The PRs remain unmerged; these links are not proof of post-merge promotion through real environments.

## Proposed demo structure

### 1 Overall

**Time: 0:00 to 0:45**

Open: [Application callers](https://github.com/JSL-Inc/golden-path-sandbox-v2/tree/release-eqa-demo-quality-20261028/.github/workflows) · [Central reusable workflows](https://github.com/JSL-Inc/golden-path-workflows-v2/tree/demo/quality-artifactory-20261028/.github/workflows) · [Golden Path CI caller](https://github.com/JSL-Inc/golden-path-sandbox-v2/blob/feature-eint4-f9241/.github/workflows/golden-path-ci.yml) · [Golden Path CD caller](https://github.com/JSL-Inc/golden-path-sandbox-v2/blob/feature-eint4-f9241/.github/workflows/golden-path-cd.yml)

1. Start in the application repository. Show that the CI and CD files call shared workflows.
2. Switch to the central repository briefly. Point to the reusable CI, reusable CD, and warning-period workflow.

**Say:**

> I’m going to follow a change through the pipeline, show the artifact integration work, and then look at the PR feedback and quality checks. The application repo supplies its commands, while the shared workflows coordinate the checks and delivery stages.

**Presenter note:** Keep this under 45 seconds. The audience does not need a file-by-file explanation.

### 2 Develop success

**Time: 0:45 to 1:45**

Open: [Example edit](https://github.com/JSL-Inc/golden-path-sandbox-v2/edit/develop-s9241/testing/test_calculator.py) · [Completed develop push CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780704658) · [Develop to feature PR 71](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/71)

1. Open the edit view to represent where a developer would start. Do not save a new edit.
2. Open the completed push CI. Show build, tests, lint, and retained evidence.
3. Open PR 71. Point to branch/flow checks and the warning-period comment. The added test is a real passing test for negative inputs.

**Say:**

> A change starts on the develop branch and gets checked before it moves on. Here the build and tests have passed and the reports are kept with the run. The PR brings the relevant results together so the developer can see what is ready and what still needs attention.

**Presenter note:** PR 71 is prepared and unmerged. Open the separately prepared feature run next; do not call it the result of merging PR 71.

### 3 Feature success and Artifactory

**Time: 1:45 to 4:00**

Open: [Feature CI](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699552) · [Feature Golden Path CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699635) · [Feature to release PR 72](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72) · [Artifact evidence](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780699552) · [Artifactory adapter](https://github.com/JSL-Inc/golden-path-workflows-v2/blob/5a44961adfc91267f6a1a868245cf4d6b17d7b27/.github/actions/artifactory-evidence/evidence.py)

1. Show the feature CD graph. Open Determine Delivery Plan, CI Success Gate, and Resolve Validated Artifact.
2. Explain that CD targets eint4 and retrieves the output from successful CI for the same commit.
3. Point to the later test/gate jobs without opening every job. They are skipped in this rehearsal.
4. Use the artifact evidence summary and metadata to explain the Artifactory package path and its separation from ACR.

**Say:**

> On the feature branch, CD determines the target and checks that CI passed for this same change before retrieving its output. There is also an Artifactory path for packaged output, with information tying it back to the application and source commit. That is separate from the ACA container-image path, which uses ACR. In this sandbox run the package evidence is local; I’m not showing a completed external Artifactory upload.

**Presenter note:** The first three CD jobs passed. The final review stop is intentional. It does not demonstrate successful INT deployment or testing. The Artifactory helper was added for rehearsal and is not proof of the enterprise integration.

### 4 Release example and current status

**Time: 4:00 to 4:30**

Open: [Prepared release CD](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780695963) · [Earlier release output](https://github.com/JSL-Inc/golden-path-sandbox-v2/releases/tag/v3.1.0) · [Original ACA caller](https://github.com/JSL-Inc/golden-path-sandbox-v2/blob/release-eqa-demo-quality-20261028/docs/demo-reference/golden-path-cd.yml)

1. Show that the release branch selects QA and includes the optional ePreProd path in the existing workflow.
2. Use the earlier release page only as a brief example of the release output.
3. Give the ACA status in one sentence and move on.

**Say:**

> The release path adds QA and, when selected, ePreProd qualification before production. Release automation is part of that flow. I’ve also been working on making ACA through ACR the primary container delivery path, but end-to-end deployment validation is still in progress.

**Presenter note:** The v3.1.0 release is historical. Do not describe it as produced by these runs. Production deployment, current release creation, and rollback are not demonstrated.

### 5 Live PR interaction

**Time: 4:30 to 6:00**

Open: [Create the live feature to release PR](https://github.com/JSL-Inc/golden-path-sandbox-v2/compare/release-epreprod-demo-20261028...feature-eint5-f9242?expand=1) · [Prepared matching PR fallback](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72) · [Prepared warning comment fallback](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/72#issuecomment-6482393831) · [Current release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084)

1. Open the compare link. Confirm base release-epreprod-demo-20261028 and head feature-eint5-f9242.
2. Create a draft PR titled Demo live feature to release. Do not request reviewers or enable auto-merge.
3. Show the checks beginning. While jobs queue, switch to PR 72 and its completed warning comment.
4. Point out passing, skipped, missing, and failing results, then show which results the ruleset actually requires.

**Say:**

> This is the PR view a developer would use. The warning-period summary gives visibility into the results, but it does not make a failed requirement pass. Existing required checks are enforced through the repository rules. CI passing also does not replace the environment qualification needed for promotion.

**Presenter note:** The compare branch is prepared but no PR has been opened for it. Leave the new PR unmerged. If you already opened it during rehearsal, reuse that PR or rerun its checks rather than creating a duplicate.

### 6 Failure and quality checkpoints

**Time: 6:00 to 7:00**

Open: [Prepared failure PR 73](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73) · [Failed unit-test run](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713809) · [CD CI prerequisite failure](https://github.com/JSL-Inc/golden-path-sandbox-v2/actions/runs/40780713639) · [Failure warning comment](https://github.com/JSL-Inc/golden-path-sandbox-v2/pull/73#issuecomment-6482394900) · [Current release ruleset](https://github.com/JSL-Inc/golden-path-sandbox-v2/rules/22672084)

1. Show the intentional assertion failure: subtract(5, 3) was expected to equal 3.
2. Open the failed CI prerequisite in CD. It did not retrieve a validated artifact.
3. Show the PR warning comment and the required CI/promotion results.
4. Connect the example to the quality work with the quality team: checks produce evidence, qualification controls progression, and repository rules determine what is required.

**Say:**

> Here I deliberately made a test fail. CI reports the failure, and CD cannot use the change because its CI prerequisite is not satisfied. The warning comment makes that visible, while the required results control progression. This is how the quality checks we’ve been working through show up in the developer’s workflow.

**Presenter note:** This is a staged demo failure. It is not a previously discovered product defect. Do not use bypass to finish the example.

## Before the demo

- Open the five main tabs in advance: develop PR 71, feature CD, Artifactory evidence, live compare, and failure PR 73.
- Keep the warning comments and ruleset open in background tabs.
- Leave the live compare branch unopened until the live segment; if rehearsed, reuse the resulting PR.
- Use the original quality diagram only with its exact labels. The materials map the controls without inventing phase names.
- Do not wait for all jobs. Use the completed matching example while new checks queue.
- Do not merge, change rulesets, use bypass, or start Azure delivery during this walkthrough.

## Five minute cut

Keep the order. Spend 30 seconds on orientation, 30 seconds on develop, 2 minutes on feature/CD/Artifactory, 15 seconds on release status, 1 minute on the live PR and warning summary, and 45 seconds on one failure and the required checks.

## Optional live repair

[Edit the intentional failure](https://github.com/JSL-Inc/golden-path-sandbox-v2/edit/feature-eint6-f9243/testing/test_calculator.py): change `assert subtract(5, 3) == 3` to `== 2` and commit on `feature-eint6-f9243`. CI and CD rerun. Deployment remains disabled. Use this instead of opening a live PR if you prefer one live edit; do not try both in seven minutes.

## Verified scope

| Area | Scope |
|---|---|
| CI and required reports | Real build/test/lint runs; develop adds one real passing test. |
| CI to CD handoff | Real target selection, same-commit CI prerequisite, and artifact retrieval. |
| Environment qualification | Not executed. Deployment and INT/QA/ePreProd gate jobs are skipped. |
| Warning period | Existing workflow restored to the isolated demo and verified on PRs. |
| Artifactory | Local rehearsal package/metadata only. No external service round trip verified. |
| ACR and ACA | Implementation/configuration visible; these runs do not build an ACR image or deploy to ACA. |
| Release output | v3.1.0 is an existing historical release, not a result of the new demo runs. |
| Governance | Active release ruleset requires CI and Promotion Gate; zero approvals and owner bypass are currently configured. |
| Security scans | The notice can report missing results. It does not run CodeQL, FOSSA, or secret scanning. |
| Prepared progression | Stage snapshots were run separately. They do not prove one artifact was promoted through all environments. |

### Connection to the quality model

Use the original quality diagram if it is available. Point to checks and retained evidence in CI, qualification at INT/QA/ePreProd, and required results in repository rules. Use the diagram’s own labels; no phase names are invented here.

### Artifactory detail

The supplied work comparison describes packaging with application/source metadata and downstream Artifactory retrieval. The linked adapter is a new personal rehearsal helper, not a verified copy of that implementation. The sandbox demonstrates local package identity; external publication/retrieval is not verified. Do not introduce the helper itself as prior completed work.

### Security and enforcement detail

The warning notice reports observable checks and can show missing/skipped results. It does not run security scanners or turn a missing check into a pass. Coverage is enforced by the application test command; the notice may still lack a standalone coverage check. The release ruleset currently requires CI and Promotion Gate, with zero approving reviews and an owner bypass. No ruleset was weakened for this demo.
