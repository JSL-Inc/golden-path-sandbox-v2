# GitLab-to-GitHub mapping

| GitLab concept | GitHub implementation | Equivalence |
|---|---|---|
| Protected branches | Repository/organization rulesets | Direct with different administration model |
| Merge request | Pull request | Direct |
| MR approval rules | Required reviews, teams, CODEOWNERS, policy checks | Partial |
| MR templates | Pull-request template | Direct |
| CI/CD includes/templates | Reusable workflows and workflow templates | Different implementation |
| Pipeline stages | Jobs and `needs` dependencies | Direct conceptually |
| Environments | GitHub Environments | Direct |
| Protected environments | Environment reviewers, secrets, and branch policies | Direct/partial |
| Merged-results pipeline | Strict status checks/merge queue | Different implementation |
| Test reports | JUnit XML artifacts and summaries | Partial; UI differs |
| Coverage report | Cobertura XML artifact and workflow summary | Partial; UI differs |
| GitLab Release | Tag plus GitHub Release | Direct |
| Code owners | CODEOWNERS | Direct |
| GitLab security scans | CodeQL, secret scanning, Dependabot, third-party tools | Different capability set |
| Compliance framework | Organization rulesets, required workflows/checks, audit log | Different implementation |
