# Environment and deployment model

| GitHub Environment | Branch mapping | Trigger | Protection | Deployment behavior |
|---|---|---|---|---|
| `eint1`–`eint6` | `feature-eint1-*`–`feature-eint6-*` | Successful Standard CI push | None by default | Automatic deployment and smoke test |
| `eqa` | `release-*`, `hotfix-*` | Successful release/hotfix validation | QA/business reviewers where required | Automatic request using the immutable release artifact |
| `epreprod` | `release-*`, `hotfix-*` | Successful EQA deployment | Release approver where required | Automatic request using the same immutable release artifact |
| `prod` | `main` | Merged release/hotfix PR | Production reviewers; prevent self-review | Automatic request using the same artifact promoted through QA/preprod |

## Promotion behavior

1. `Branch CI and Delivery` produces one immutable artifact for a real branch push.
2. A successful `feature-eintN-*` push automatically deploys its artifact to `eintN`.
3. A successful `release-*` or `hotfix-*` push runs integration and regression once, requests `eqa`, then requests `epreprod` with the same artifact.
4. Merging that release/hotfix PR to `main` starts `Production Release`; it locates the successful source-branch run instead of rebuilding.
5. The protected `prod` Environment pauses for approval when reviewers are configured.
6. Production verification runs automatically after deployment.
7. Semantic Release reads the merged PR's single SemVer label and creates the matching tag and GitHub Release.

The manual **Rollback or Redeploy Artifact** workflow is a recovery control. Run
it from a source branch permitted by the selected Environment; it is not part of
the normal demonstration path.

Deployment concurrency is scoped to repository and environment. `cancel-in-progress: false` prevents a running deployment from being interrupted.

## Rollback and revert

- Rollback redeploys a previously successful immutable artifact.
- Revert creates a new Git commit that undoes a source change while retaining history.
- Production credentials never appear in source or plaintext workflow inputs.
- The POC deployment script is an adapter boundary, not a claim of production infrastructure integration.
