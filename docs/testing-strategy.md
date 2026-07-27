# Testing strategy

| Test type | Scope | Typical trigger | POC behavior | Blocking guidance |
|---|---|---|---|---|
| Unit | Isolated function/class/module | Every PR and protected-branch update | Runnable pytest example | Required |
| Integration | Service/database/API interaction | Release branches or selected PRs | PostgreSQL service-container extension point | Required where applicable |
| Regression | Previously working behavior | Release branch, schedule, high-risk change | Runnable test-suite extension point | Critical apps/release gate |
| System | Complete application in a production-like environment | QA readiness or release approval | Environment-gated adapter | Defined by application/TCE |
| Performance | Latency, throughput, resource baseline | Manual/scheduled/release | Integration Environment adapter | Recommended |
| DAST | Deployed application attack surface | Non-production deployment | ZAP baseline with TSV rules and evidence | Advisory first; risk-based blocking |
| Smoke | Basic deployment health | Immediately after deployment | Confirms promoted artifact exists | Required |

## Unit-test and coverage contract

- Run unit tests before build.
- Fail on any unit-test failure.
- Finish unit tests in under ten minutes or add sharding/parallelization.
- Emit JUnit XML at the configured path.
- Emit Cobertura XML with root `line-rate`.
- Enforce 80% line coverage for applications subject to the baseline.
- Permit warning-only transition mode only with a nonblank approved exception reference.
- Upload reports even when a preceding test or coverage step fails.

Coverage generation is not the same as coverage enforcement: a report can exist while the percentage remains below policy. The reusable workflow validates both report existence and the configured threshold.

## Test-data and cleanup guidance

- Use synthetic or approved masked data.
- Prefer service containers for deterministic PR tests.
- Use mocks when testing failure modes or when a real dependency is unavailable.
- Use real non-production integrations for release validation when risk justifies it.
- Create isolated test identifiers and remove data after execution.
- Retain evidence according to the workflow and enterprise retention policy.
