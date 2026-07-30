# Executive summary

This proof of concept translates the supplied COUNTRY GitLab delivery standards into a native GitHub Enterprise Cloud Golden Path. It separates centrally maintained orchestration from application-specific commands, protects promotion with pull requests and status checks, retains test and security evidence, and promotes one immutable artifact through protected environments.

The POC intentionally preserves the current documented branch flow:

```text
main → release → feature → develop
develop → feature → release → main
hotfix → main → release → feature
```

It does not silently replace that model with conventional GitFlow. A reusable pull-request policy validates the allowed transitions and requires exactly one semantic-version label on changes entering `main`.

## Outcomes demonstrated

- Reusable CI, security, DAST, deployment, production-verification, release, and PR-policy workflows
- JUnit XML and Cobertura XML evidence with a blocking 80% line-coverage baseline
- Architecture-aligned build and quality validation
- Ruleset specifications for `feature-*`, `prerelease-*`, `release-*`, and `main`
- Protected Integration, QA, Preproduction, and Production environment specifications
- Build-once artifact promotion with deployment concurrency
- CodeQL, dependency review, Dependabot, secret-protection guidance, and non-production ZAP
- Semantic version validation using `major`, `minor`, or `patch`
- Matching production-verification evidence required before the official tag and GitHub Release
- An auditable, expiring control-exception template

## Responsibility split

| Location | Responsibility |
|---|---|
| `golden-path-workflows-v2` | Central reusable workflow logic and gates |
| `golden-path-template-v2` | Approved application-repository starter and governance specifications |
| `golden-path-sandbox-v2` | Runnable demonstration consumer |
| `github-community-v2` | Staging area for organization community files and workflow templates |
| GitHub organization/repository settings | Rulesets, environments, reviewers, labels, GHAS controls, and template-repository setting |

Committed files provide the implementation and API-ready governance specifications. GitHub settings remain settings: they are not falsely represented as enforced merely because their JSON specifications are in the repository.
