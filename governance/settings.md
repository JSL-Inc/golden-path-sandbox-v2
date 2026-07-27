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

## Labels

- `major`
- `minor`
- `patch`
- `security-exception`
- `coverage-transition`
- `hotfix`

## Environments

Create Integration, QA, Preproduction, and Production using `environments.json`. Add approved team/user reviewers before enabling the production gate.

## Rulesets

Apply the JSON specifications in `governance/rulesets/` after each named status check has completed successfully at least once. GitHub only allows selecting a required check after it has reported in the repository recently.

The current GitLab standard leaves hotfix branches unprotected. For the GitHub future state, use an expedited PR and narrowly scoped audited bypass rather than normal direct pushes.

## Community repository

GitHub organization-wide workflow templates require a repository named exactly `.github`. Promote `github-community-v2` by copying or renaming it after approval.
