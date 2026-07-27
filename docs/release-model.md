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
3. `Production Release` identifies the merged release/hotfix PR and its successful `Branch CI and Delivery` run.
4. It promotes that source run's immutable artifact to the protected `prod` Environment; `main` is not rebuilt.
5. After Environment approval and a successful deployment, production verification runs automatically.
6. Semantic Release uses the merged PR associated with the deployed main commit.
7. It reads the single release label and calculates the next version from the latest `vMAJOR.MINOR.PATCH` tag.
8. It validates the production-verification evidence against the deployed commit.
9. It creates the Git tag and generated GitHub Release.

Dependabot branches execute the same CI, integration, regression, artifact,
production, verification, and release sequence. Their missing SemVer label is
treated as `patch`; an explicit SemVer label still takes precedence.

Manual recovery inputs remain on `Production Release` for an operator to supply
the merged PR, artifact run, and main commit if automatic discovery is
interrupted. Release creation is idempotent: a rerun reuses an existing SemVer
tag on the same commit and does not create a duplicate GitHub Release.

## Hotfix

A hotfix uses `patch`, skips the feature-ID tag, and follows the same artifact, production-verification, and final-release gates. After merging to `main`, the change is synchronized into active release and feature branches.

## Artifactory production adapter

The POC uses GitHub Actions artifacts to remain runnable without enterprise credentials. The production adapter must add:

- Approved repository coordinates
- Checksum and provenance
- Retention policy
- OIDC or approved secret authentication
- Promotion of the same artifact instead of rebuilding
