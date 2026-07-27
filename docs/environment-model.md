# Environment and deployment model

| GitHub Environment | COUNTRY mapping | Trigger | Approval | Branch policy | Secrets | Deployment |
|---|---|---|---|---|---|---|
| Integration | `eint1`–`eint6` | Feature/release promotion | None by default | `feature-*`, `release-*` | Environment-scoped | Automatic where a dedicated environment exists |
| QA | `eqa` | Release/hotfix validation | QA/business as defined | `release-*`, `hotfix-*` | Environment-scoped | Controlled |
| Preproduction | `epreprod` | Release/hotfix validation | Release approver | `release-*`, `hotfix-*` | Environment-scoped | Controlled |
| Production | `prod` | Approved main/tag release | Leadership/production reviewer; prevent self-review | Protected branches/tags | Environment-scoped or OIDC | Manual approval, automated execution |

## Promotion behavior

1. CI creates one immutable artifact.
2. Deployment receives the producing workflow-run ID and artifact name.
3. GitHub downloads that exact artifact.
4. The deployment job enters the named Environment and waits for its protection rules.
5. The application adapter deploys the artifact.
6. A smoke test validates basic health.
7. The same artifact is promoted to the next environment.

Deployment concurrency is scoped to repository and environment. `cancel-in-progress: false` prevents a running deployment from being interrupted; GitHub serializes deployments so an older pending run cannot overtake an active one.

## Rollback and revert

- Rollback redeploys a previously successful immutable artifact.
- Revert creates a new Git commit that undoes a source change while retaining history.
- Production credentials never appear in source or plaintext workflow inputs.
- The POC deployment script is an adapter boundary, not a claim of production infrastructure integration.
