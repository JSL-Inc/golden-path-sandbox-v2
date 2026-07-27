# Repository and organization settings

These settings cannot be represented by committed files alone.

## Repository

- Mark `golden-path-template-v2` as a template repository.
- Enable squash merge.
- Disable merge commits and rebase merge for the standardized POC.
- Enable automatically deleting head branches.
- Enable auto-merge if desired.
- Enable vulnerability alerts and Dependabot security updates.
- Enable CodeQL, secret scanning, and push protection where licensed.

## Labels and behavior

- `major`: next verified production release increments the major version.
- `minor`: next verified production release increments the minor version.
- `patch`: next verified production release increments the patch version.
- `security-exception`
- `coverage-transition`
- `hotfix`
- `dependencies`

Exactly one SemVer label is required on a PR entering `main`. The other labels
are classification/evidence labels and do not change version calculation.

## Environments

Create `eint1` through `eint6`, `eqa`, `epreprod`, and `prod` using `environments.json`. Add approved team/user reviewers before enabling shared-stage gates. All deployment requests are automatic; configured Environment reviewers control when EQA, ePreProd, and production jobs proceed.

## Rulesets

Apply the JSON specifications in `governance/rulesets/` after each named status check has completed successfully at least once. GitHub only allows selecting a required check after it has reported in the repository recently.

Enable **Do not require status checks on creation**. Branch creation can then
complete without a meaningless CI run; the first subsequent content push
produces the required evidence.

The current GitLab standard leaves hotfix branches unprotected. For the GitHub future state, use an expedited PR and narrowly scoped audited bypass rather than normal direct pushes.

## Community repository

GitHub organization-wide workflow templates require a repository named exactly `.github`. Promote `github-community-v2` by copying or renaming it after approval.
