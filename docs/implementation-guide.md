# Implementation guide

## 1. Central workflows

1. Publish `golden-path-workflows-v2`.
2. Create the `v2` release branch at the reviewed commit.
3. Restrict direct updates to the release channel for a production rollout.
4. Replace the mutable POC channel with immutable tags or commit SHAs before broad adoption.

## 2. Application repository

1. Create from `golden-path-template-v2`.
2. Replace the sample application and scripts beneath `scripts/`.
3. Replace `@jacoblaw1` with approved CODEOWNERS teams.
4. Run each workflow once before selecting its exact check name in a ruleset.
5. Create the labels listed in `governance/settings.md`; only the three SemVer
   labels affect automatic release versioning.

## 3. Repository settings

- Enable squash merge.
- Disable merge commits and rebase merge.
- Enable automatic head-branch deletion.
- Enable vulnerability alerts and Dependabot security updates.
- Enable CodeQL/default setup or the committed advanced workflow, secret scanning, and push protection where eligible.
- Mark the approved source as a template repository.

## 4. Rulesets

Apply the JSON specifications in `governance/rulesets/` only after the corresponding checks have reported. Confirm the exact names in the repository UI because GitHub composes reusable-workflow job names.

Validate:

- Direct push blocked
- Force push and deletion blocked
- Strict status checks
- Stale-review dismissal
- Last-pusher approval
- Resolved conversations
- Squash-only merge
- One feature approval and two release/main approvals

Role-specific Developer/Maintainer and leadership/security approval requires real GitHub teams, CODEOWNERS, or an additional policy check.

## 5. Environments

Create `eint1` through `eint6`, `eqa`, `epreprod`, and `prod` from `governance/environments.json`. Add real reviewers, branch policies, scoped secrets/variables, and prevent self-review for protected stages. EINT, EQA, ePreProd, and production requests are automatic. Environment reviewers provide the human gates. Use **Rollback or Redeploy Artifact** only for recovery.

## 6. Demonstration branches

- `release-eqa-poc-release` from `main`
- `feature-eint1-f26` from that release branch
- `develop-s34` from that feature branch

Use pull requests to promote develop → feature → release → main. The release
branch name no longer selects only one shared stage; the same release candidate
automatically moves through both EQA and ePreProd.

## 7. Evidence

Retain:

- JUnit and Cobertura artifacts
- Build checksum and package
- Integration/regression/system/DAST output where applicable
- Environment deployment history
- Production verification JSON
- Final tag and GitHub Release
- Exception issue and RSAM reference when used
