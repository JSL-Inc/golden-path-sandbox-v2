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
3. The successful `main` CI requests the protected `prod` Environment with its immutable artifact.
4. After Environment approval and a successful deployment, production verification runs automatically.
5. Semantic Release identifies the merged PR associated with the deployed main commit.
6. It reads the single release label and calculates the next version from the latest `vMAJOR.MINOR.PATCH` tag.
7. It validates the production-verification evidence against the deployed commit.
8. It creates the Git tag and generated GitHub Release.

Manual dry-run mode remains available for testing the version calculation without creating a tag or release. GitHub rejects an existing duplicate tag/release, preventing accidental duplicate publication.

## Hotfix

A hotfix uses `patch`, skips the feature-ID tag, and follows the same artifact, production-verification, and final-release gates. After merging to `main`, the change is synchronized into active release and feature branches.

## Artifactory production adapter

The POC uses GitHub Actions artifacts to remain runnable without enterprise credentials. The production adapter must add:

- Approved repository coordinates
- Checksum and provenance
- Retention policy
- OIDC or approved secret authentication
- Promotion of the same artifact instead of rebuilding
