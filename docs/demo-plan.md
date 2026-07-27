# POC demonstration walkthrough

The normal path is automatic. Manual deployment, DAST, system, and performance
workflows are recovery or optional demonstrations, not prerequisites.

Dependabot is the deliberate exception to the COUNTRY branch names: its branch
gets the same single CI/integration/regression run and defaults to a patch
release if merged.

## Before the meeting

1. Apply the rulesets in `governance/rulesets/`.
2. Configure `eint1`–`eint6`, `eqa`, `epreprod`, and `prod` from
   `governance/environments.json`.
3. Add reviewers to `eqa`, `epreprod`, and `prod`; enable prevent self-review.
4. Create the `major`, `minor`, and `patch` labels.
5. Create `release-eqa-poc-release`, then `feature-eint1-f26`, then `develop-s34`.

## What the audience sees

### 1. Story development

Push an application and unit-test change to `develop-s34`.

- Exactly one **Branch CI and Delivery** run appears.
- Standard CI runs tests before build.
- JUnit XML, Cobertura XML, checksum, and `application-package` are retained.
- Coverage below 80% or any failed test blocks promotion.
- No deployment runs because a develop branch is local-development scope.

Opening `develop-s34 → feature-eint1-f26` starts the PR-policy check and the
optional security scan. Standard CI is not duplicated on the PR event.

### 2. Feature integration

After approval, squash merge into `feature-eint1-f26`.

- One **Branch CI and Delivery** run validates the feature head.
- Integration testing runs in the same workflow.
- The resulting artifact automatically deploys to `eint1`.
- A smoke-test result and GitHub Environment deployment record are retained.

Open `feature-eint1-f26 → release-eqa-poc-release`. The ruleset requires Standard CI,
Integration Test, PR policy, and the configured approvals.

### 3. Release candidate

After approval, squash merge into `release-eqa-poc-release`.

- One **Branch CI and Delivery** run executes Standard CI, integration, and
  regression.
- That run creates the release-candidate artifact once.
- The same artifact automatically requests deployment to `eqa`.
- After the EQA Environment gate, the same artifact requests `epreprod`.
- After the preproduction gate, the release candidate is ready for production.

Open `release-eqa-poc-release → main` and add exactly one `major`, `minor`, or `patch`
label. PR policy shows why zero or two labels are rejected. Obtain the two
required approvals and merge.

### 4. Production and official release

The merge starts one **Production Release** run.

- It resolves the merged release PR and the successful release-branch run.
- It downloads that run's artifact; it does not rebuild on `main`.
- It requests the protected `prod` Environment.
- After approval, it deploys, smoke tests, and performs production verification.
- It validates verification evidence against the merged main commit.
- It calculates the next SemVer from the PR label.
- It creates the `vMAJOR.MINOR.PATCH` tag and GitHub Release automatically.

### 5. Optional controls

Show CodeQL/security results separately. Run DAST, system, or performance tests
manually if they help the audience; they do not generate a second copy of core
CI. Show **Rollback or Redeploy Artifact** as the operator recovery path.

## Acceptance

- A real branch push creates one core CI/delivery run.
- Branch-creation records skip all jobs until content is pushed.
- Direct updates to protected branches are blocked.
- PR transitions and release classification are enforced.
- JUnit, Cobertura, build checksum, and deployment evidence are retained.
- The release artifact is promoted without rebuilding.
- Protected Environment reviewers can pause shared and production deployment.
- A GitHub Release appears only after matching production verification.
