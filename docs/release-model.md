# Release and semantic-version model

## Classification

Every pull request entering `main` must have exactly one label:

- `major`: incompatible or significant change
- `minor`: backward-compatible feature
- `patch`: backward-compatible correction or hotfix

The PR-policy workflow rejects missing or duplicate classifications.
Dependabot PRs are the narrow exception: when no release label exists, the
workflow classifies the dependency update as `patch`.

## Release sequence

1. Classify the release PR.
2. Merge the validated release or hotfix branch to `main`.
3. Supply the merged release PR number; the workflow reads its single release label.
4. Calculate the next version from the latest `vMAJOR.MINOR.PATCH` tag.
5. Produce the versioned immutable artifact; the production adapter publishes it to Artifactory.
6. Promote that artifact through QA and Production.
7. Run production verification.
8. Retain `production-verification-<version>` evidence.
9. Supply the successful verification run ID to the release workflow.
10. Confirm the evidence version matches the calculated release version.
11. Create the Git tag and generated GitHub Release.

Dry-run mode calculates the next version without creating a tag or release. GitHub rejects an existing duplicate tag/release, preventing accidental duplicate publication.

## Hotfix

A hotfix uses `patch`, skips the feature-ID tag, and follows the same artifact, production-verification, and final-release gates. After merging to `main`, the change is synchronized into active release and feature branches.

## Artifactory production adapter

The POC uses GitHub Actions artifacts to remain runnable without enterprise credentials. The production adapter must add:

- Approved repository coordinates
- Checksum and provenance
- Retention policy
- OIDC or approved secret authentication
- Promotion of the same artifact instead of rebuilding
