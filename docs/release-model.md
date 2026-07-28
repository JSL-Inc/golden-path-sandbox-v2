# Simple release model

## One required label

Every release or hotfix pull request entering `main` has exactly one label:

- `major` for an incompatible or significant change
- `minor` for a backward-compatible feature
- `patch` for a backward-compatible fix

`Pull Request Policy` blocks the pull request when none or more than one of
these labels is present.

## What happens after merge

The merged pull request event already contains the source branch, commit, and
labels, so the workflow does not rediscover them with custom code.

1. Read the single release label.
2. Find the latest `vMAJOR.MINOR.PATCH` Git tag.
3. Calculate the next version with a short Bash `case`.
4. Find and download the successful CI artifact for the release branch.
5. Request the protected `prod` Environment.
6. Deploy, smoke test, and record production verification.
7. Create the Git tag and GitHub Release with the artifact and verification
   evidence attached.

The workflow is rerun-safe: if the merged commit already has a SemVer tag or
the GitHub Release already exists, it reuses it.

There is no version file to maintain, no version-update commit, and no reusable
release workflow caller. Git tags and GitHub Releases are the source of truth.

## Feature traceability

Merging `feature-eint1-f26` into a release branch creates the lightweight `f26`
tag on that release-branch merge commit. The feature tag is traceability only;
it does not choose or change the semantic version.

## POC artifact storage

The POC keeps the build in GitHub Actions and promotes that same artifact
without rebuilding. The GitHub Release attaches:

- the packaged application artifact
- production-verification evidence
- the source snapshot and generated release notes GitHub provides

Artifactory integration is intentionally outside this POC.
