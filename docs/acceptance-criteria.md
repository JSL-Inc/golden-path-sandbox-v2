# POC acceptance criteria

| Criterion | Demonstration evidence |
|---|---|
| Protected branches reject direct updates | Active GitHub ruleset |
| Changes flow through pull requests | Ruleset plus branch-policy check |
| Reviews and status checks are required | Active ruleset and blocked merge UI |
| Unit-test failure blocks merge | Failed `Standard CI / Golden Path CI` |
| Coverage is generated and enforceable | JUnit/Cobertura artifacts and 80% gate |
| Branches follow the documented flow | Passing PR-policy status check |
| Releases use semantic versioning | Exactly one release label and calculated version |
| Tag and GitHub Release are automated | Successful release workflow after verification evidence |
| Deployments use protected Environments | QA/Production deployment history and approval |
| Secrets are not embedded | Environment/OIDC configuration and workflow review |
| Controls are reusable | Sandbox calling central `@v2` workflows |
| Responsibilities are separated | Architecture and control matrix |
| Optional controls can be added incrementally | Security and expanded-testing extension workflows |

The acceptance criterion is complete only when its GitHub setting is active. A committed ruleset or environment specification alone is implementation documentation, not proof of enforcement.
