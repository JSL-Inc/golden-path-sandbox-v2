# Known limitations and future improvements

- `github-community-v2` is not active organization-wide because GitHub requires the special repository name `.github`.
- `@v2` is a mutable POC channel; production consumers should use reviewed immutable release tags or commit SHAs.
- GitHub Actions artifacts demonstrate promotion but are not the enterprise Artifactory system of record.
- Real deployment, monitoring, ServiceNow, Rally, RSAM, and defect-reporting endpoints were not supplied.
- Team identities for Developer, Maintainer, Security, Product Owner, and Manager/Supervisor approval are not yet defined.
- Standard GitHub approvals cannot perfectly express every GitLab role-pair requirement without teams, CODEOWNERS, or a custom policy check.
- The exact prerelease promotion path and complete Standard QA Workflow were not visible in the supplied evidence.
- CodeQL, secret scanning, push protection, and dependency review depend on repository eligibility, licensing, and settings.
- ZAP is advisory until the target application and rules are tuned.
- The sample system, performance, monitoring, and deployment scripts are adapter boundaries rather than production test suites.
- Required-check display names must be confirmed after their first successful run.
- Coverage transition duration and security exception ownership need formal governance.
