# Golden Path standards

## Branch flow

The POC preserves the supplied COUNTRY GitLab model:

```text
main
  └─ release-<eqa|epreprod>-<description>
       └─ feature-<eint environment>-<Rally feature ID>
            └─ develop-<Rally story ID>
```

Promotion uses pull requests:

```text
develop → feature → release → main
```

Emergency repair:

```text
main → hotfix-<environment>-<description> → main → release → feature
```

The current-state standard allows direct emergency changes on unprotected hotfix branches. The recommended GitHub future state is an expedited hotfix PR with an audited bypass only when necessary.

## Pull requests

- PR required for promotion into feature, release, and main
- One approval for feature/prerelease
- Two approvals for release: one Developer and one Maintainer
- Two approvals for main: technical approval plus Manager/Supervisor oversight
- Author/committer cannot be the only approver for main
- Resolve conversations and synchronize with the target branch
- Squash merge is the default
- The PR-policy status check validates the allowed COUNTRY source/target branch transition
- PRs entering `main` must have exactly one of `major`, `minor`, or `patch`

## Test and coverage

- JUnit XML is mandatory
- Cobertura XML line coverage is mandatory
- 80% is blocking for applications subject to the baseline
- Warning-only transition requires a documented exception
- Tests execute before build and should finish in under ten minutes

## Environments

| GitHub Environment | Current-state mapping | Gate |
|---|---|---|
| Integration | `feature-eint1-*`–`feature-eint6-*` | Automated deployment and smoke test |
| QA | `release-eqa-*` / `hotfix-eqa-*` | Protected; QA and business evidence |
| Preproduction | `release-epreprod-*` / `hotfix-epreprod-*` | Protected; release approval |
| Production | `main` | Protected; self-review prevented and leadership approval |

A release or hotfix branch selects exactly one shared environment from its name; EQA and ePreProd are not chained.

## Releases

- Calculate `MAJOR.MINOR.PATCH`
- Build once
- Publish the versioned artifact to Artifactory in production
- Promote the same artifact through the selected shared environment and production
- Verify production
- Retain the successful production-verification evidence artifact
- Create the official tag and GitHub Release only when that matching evidence is supplied

## Security

- CodeQL SAST
- Secret scanning and push protection
- Dependency alerts and dependency review
- High/critical findings require Security and business/leadership approval
- DAST targets non-production by default
- Exceptions require documented justification and expiry
