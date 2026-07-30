# Repository and organization settings

These settings cannot be enforced by committed files alone.

## `golden-path-sandbox-v2`

- Use this repository as the demonstration/template candidate.
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

## Environments in the sandbox/application repository

Create `eint1` through `eint6`, `eqa`, `epreprod`, and `prod` using `environments.json`. Add approved team/user reviewers before enabling shared-stage gates. All deployment requests are automatic; configured Environment reviewers control when EQA, ePreProd, and production jobs proceed.

## Repository rulesets in `golden-path-sandbox-v2`

Apply the JSON specifications in `governance/rulesets/` after the named status
checks have reported in this repository at least once.

| Ruleset | Target | Required workflow checks |
|---|---|---|
| `golden-path-feature-branches-v2` | `feature-*` | `Branch Policy / Branch Name`, `PR Flow / Branch Flow`, `PR Quality / Coverage 80%`, `Delivery / Build and Quality Checks` |
| `golden-path-release-branches-v2` | `release-*` | `Branch Policy / Branch Name`, `PR Flow / Branch Flow`, `PR Quality / Coverage 80%`, `Delivery / INT Gate` |
| `golden-path-main-v2` | default branch (`main`) | `Branch Policy / Branch Name`, `PR Flow / Branch Flow`, `PR Quality / Coverage 80%`, `SemVer Policy / Release Label`, `Delivery / Release Readiness` |
| `golden-path-managed-tags-v2` | tags `v*` and `f*` | Block deletion and non-fast-forward tag updates |

For each branch ruleset, also enable:

- Require a pull request.
- Dismiss stale approvals and require approval after the last push.
- Require conversation resolution.
- Block branch deletion and force pushes.
- Require CodeQL results: alerts at errors and warnings; security alerts at
  high or higher.
- If GitHub Code Quality is enabled, require code-quality results at errors and
  restrict total coverage to 80%. The custom `PR Quality / Coverage 80%` check
  remains the portable POC evidence check.

Use one approval for `feature-*`; use two approvals for `release-*` and `main`.
The main ruleset should require the branch to be up to date before merging.

Enable **Do not require status checks on creation**. Branch creation can then
complete without a meaningless CI run; the first subsequent content push
produces the required evidence.

The current GitLab standard leaves hotfix branches unprotected. A hotfix still
enters `main` through the main ruleset. For a future production model, use an
expedited PR and a narrowly scoped audited bypass instead of normal direct
pushes.

## `golden-path-workflows-v2`

Apply a separate `central-workflow-main-protection` repository ruleset to
`main`: require a pull request, one approval, CODEOWNERS review, conversation
resolution, and block deletion/force pushes. Do not require the application
delivery checks in the central repository.

## Organization-level future state

Repository-level status checks are correct for the POC because the caller jobs
report their statuses in the application repository. Organization required
workflows are a separate organization/enterprise ruleset capability and cannot
be configured as a repository rule. After the POC, organization rulesets can
target repositories with a custom property such as `golden_path=enabled`.
