# Organization template demonstration

This branch is the runnable consumer of the organization-ready template.
`new-deploy-stuff-template` is treated as the production target only in this
sandbox so the complete release can be demonstrated without changing `main`.
Generated application repositories use `main` instead.

## Demonstrate EQA only

1. Create `release-eqa-org-demo` from this branch.
2. Create `feature-eint1-f901` from that release branch.
3. Create `develop-s901` from the feature branch and make a small change.
4. Promote with pull requests: develop to feature, feature to release.
5. Confirm `INT Gate`, then `QA Gate` and `Release Readiness`.
6. Open release to `new-deploy-stuff-template`, add one `patch` label, obtain
   approvals, and merge.
7. Confirm production deployment, smoke test, SemVer tag, and GitHub Release.

## Demonstrate EQA and ePreProd

Repeat the flow with `release-epreprod-org-demo`. The release run must pass EQA
and its QA Gate before the same artifact deploys to ePreProd. `Release
Readiness` succeeds only after both stages.

The organization rulesets require final gates, not every conditional child job,
which keeps the pull request readable and avoids Expected checks for unused
routes.
