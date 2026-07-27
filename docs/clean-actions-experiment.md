# Clean Actions developer-UI experiment

This branch tests a developer-focused replacement for the current single caller
that declares every possible deployment environment as a separate job.

## What changed

The experimental `.github/workflows/ci.yml` declares four understandable jobs:

1. **Delivery Plan** parses the branch once and records applicable tests and environment.
2. **Standard CI** runs the existing reusable unit-test, coverage, build, lint, and artifact workflow.
3. **Stage Validation** runs integration and regression as applicable inside one visible check.
4. **Deploy <environment>** is one dynamically routed deployment job.

A feature or release run therefore has no irrelevant environment deployment
jobs to display as skipped.

## Expected checks

| Branch | Visible core checks |
|---|---|
| `develop-s34` | Delivery Plan, Standard CI, Stage Validation; one skipped Deploy job |
| `feature-eint2-f900` | Delivery Plan, Standard CI, Stage Validation, Deploy eint2 |
| `release-eqa-clean-demo` | Delivery Plan, Standard CI, Stage Validation, Deploy eqa |
| `release-epreprod-clean-demo` | Delivery Plan, Standard CI, Stage Validation, Deploy epreprod |
| `hotfix-eqa-clean-demo` | Delivery Plan, Standard CI, Stage Validation, Deploy eqa |
| `dependabot/**` | Delivery Plan, Standard CI, Stage Validation; one skipped Deploy job |

Step-level conditions remain inside Stage Validation, but GitHub does not expose
those as separate PR checks.

## Safe test flow

The experiment branch itself intentionally does not match a delivery trigger.

1. Create `release-eqa-clean-ui-demo` from `experiment/clean-actions-developer-ui`.
2. Create `feature-eint2-f900` from that release branch.
3. Push a real application or test commit to the feature branch after creating it.
4. Confirm the feature run shows Delivery Plan, Standard CI, Stage Validation,
   and only Deploy eint2.
5. Open `feature-eint2-f900 → release-eqa-clean-ui-demo`.
6. After merging, confirm the release run shows the same three validation
   checks and only Deploy eqa.

Do not merge the experiment into `main` until its ruleset check names are
reviewed. The current rulesets reference the old Integration Test and Regression
Test contexts; adoption should replace them with the stable Stage Validation
context.

## Known GitHub limitation

GitHub evaluates every declared job. A deployment job with a false condition
appears as skipped, so development and Dependabot runs retain one skipped Deploy
job. Completely eliminating that final skipped entry would require separate
workflow files by branch class, which increases configuration and ruleset
maintenance.
