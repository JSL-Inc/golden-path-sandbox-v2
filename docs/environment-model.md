# Environment and deployment model

| GitHub Environment | Branch mapping | Trigger | Protection | Deployment behavior |
|---|---|---|---|---|
| `eint1`–`eint6` | `feature-eint1-*`–`feature-eint6-*` | Successful Standard CI push | None by default | Automatic deployment and smoke test |
| `eqa` | `release-eqa-*`, `hotfix-eqa-*` | Controlled promotion | QA/business reviewers where required | Manual promotion of an immutable CI artifact |
| `epreprod` | `release-epreprod-*`, `hotfix-epreprod-*` | Controlled promotion | Release approver where required | Manual promotion of an immutable CI artifact |
| `prod` | `main` | Successful Standard CI after merge | Production reviewers; prevent self-review | Automatic request; GitHub Environment approval gates execution |

## Promotion behavior

1. Standard CI produces one immutable artifact.
2. A successful push to `feature-eintN-*` automatically deploys that artifact to `eintN`.
3. A release or hotfix artifact is manually promoted to shared `eqa` or `epreprod` using **Promote Artifact**.
4. A successful `main` CI requests the protected `prod` environment and waits for its configured approval.
5. A successful production deployment starts production verification automatically.
6. Successful verification starts Semantic Release automatically; it reads the merged PR's SemVer label and creates the matching tag and GitHub Release.

Deployment concurrency is scoped to repository and environment. `cancel-in-progress: false` prevents a running deployment from being interrupted.

## Rollback and revert

- Rollback redeploys a previously successful immutable artifact.
- Revert creates a new Git commit that undoes a source change while retaining history.
- Production credentials never appear in source or plaintext workflow inputs.
- The POC deployment script is an adapter boundary, not a claim of production infrastructure integration.
