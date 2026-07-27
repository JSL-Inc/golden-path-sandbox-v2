# Enforcement control matrix

| Standard | GitHub mechanism | Enforcement | Location | POC |
|---|---|---|---|---|
| Branch naming and flow | Documentation plus rulesets | Validated/documented | `docs/`, repository settings | Required |
| Allowed source/target branch transitions | Reusable PR policy | Automatically validated | Central workflow and caller | Required |
| PR required | Ruleset | Technical | Repository/organization ruleset | Required |
| Approvals | Ruleset plus teams/CODEOWNERS | Technical/organizational | Ruleset and teams | Required |
| Author separation | Last-push approval and review policy | Technical/validated | Ruleset | Required |
| Resolved conversations | Ruleset | Technical | Ruleset | Required |
| Current with target | Strict required checks | Technical | Ruleset | Required |
| Unit-test pass | Reusable CI status check | Technical | Central workflow | Required |
| JUnit XML | Reusable CI validation | Technical | Central workflow | Required |
| Cobertura line coverage | Reusable CI validation | Technical | Central workflow | Required |
| 80% threshold | Reusable CI gate | Technical | Central workflow input | Required |
| Build and lint | Reusable CI status check | Technical | Central workflow | Required |
| Artifact publishing | Workflow adapter | Technical/demonstrated | Central workflow | Required |
| Integration deployment | GitHub Environment workflow | Repository-enabled | Environment and workflow | Deployable apps |
| Smoke test | Deployment workflow | Technical | Central workflow | Required |
| CodeQL | Reusable security workflow | Repository-enabled | Central workflow/GHAS | Required design |
| Secret scanning | Repository setting | Platform setting | Advanced Security settings | Required design |
| Dependency review | Reusable security workflow | Technical when available | Central workflow | Required design |
| DAST | Reusable ZAP workflow | Advisory initially | Central workflow | Conditional |
| Production approval | Protected Environment | Technical/organizational | Environment settings | Required |
| Release SemVer | Reusable release workflow | Validated | Central workflow | Required |
| Official release after verification | Workflow gate | Technical | Release workflow | Required |
| Integration/regression/system/performance | Extension workflows | Demonstrated | Application repository | Conditional |
