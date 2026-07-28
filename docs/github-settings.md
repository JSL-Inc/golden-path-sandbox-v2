# GitHub settings required outside the repository

The POC expects these organization-level settings:

- CodeQL default setup
- GitHub Code Quality
- secret scanning and push protection
- dependency graph and Dependabot alerts/security updates
- native ruleset rules for code scanning, code quality, and minimum 80% coverage
- GitHub Environments: `eint1`–`eint6`, `eqa`, `epreprod`, and `prod`

For the branch-only experiment, temporarily allow `simplified-version-1` in
the `prod` environment deployment-branch policy and target it with the desired
approval ruleset. Remove those temporary allowances after testing.

Use the organization-required `required-pr.yml` after the branch is promoted.
At that point, delete the local `pull-request.yml` caller so validation runs
once, and change the delivery workflow's `production_branch` back to `main`.
