# POC scope and non-goals

## In scope

- Current COUNTRY branch flow and naming conventions
- Pull-request template, CODEOWNERS baseline, approval guidance, and branch-transition validation
- Squash-only merge recommendation
- Required CI and security status-check design
- Unit testing, JUnit XML, Cobertura XML, and configurable coverage enforcement
- Reusable build, security, DAST, deployment, verification, and release workflows
- Integration, regression, system, and performance extension points
- GitHub Environment and ruleset specifications
- Semantic versioning and release evidence
- GitLab-to-GitHub mapping, exception guidance, control matrix, and demonstration plan

## POC assumptions

- GitHub Actions artifacts stand in for the enterprise Artifactory adapter because no non-production Artifactory endpoint or credential was supplied.
- `@v2` is the isolated POC release channel for central reusable workflows.
- Python is the runnable sample; consumers replace the scripts beneath `.github/golden-path/` for Java, .NET, JavaScript, MuleSoft, or other stacks.
- `@jacoblaw1` is the temporary CODEOWNER and must be replaced by approved teams.
- GitHub Environment names use the supplied values directly: `eint1`–`eint6`, `eqa`, `epreprod`, and `prod`.
- DAST begins advisory and may become blocking for internet-facing or high-risk applications after tuning.

## Non-goals

- Production Artifactory, ServiceNow, Rally, Splunk, Dynatrace, Azure Monitor, or RSAM connectivity without approved endpoints and credentials
- Claiming team-specific Developer, Maintainer, Security, or leadership approvals are configured before those teams are identified
- Treating a workflow template as an enforced workflow
- Scanning production with ZAP by default
- Automatically waiving security or coverage findings
- Replacing application-specific testing strategy with a generic test script
- Declaring the current hotfix direct-push exception as the approved GitHub future state

## Decisions still owned by stakeholders

- Final hotfix bypass model
- Named approval teams and leadership/security separation of duties
- Artifactory coordinates, authentication, retention, and promotion method
- Exact QA workflow and monitoring/production-health checks
- Security exception ownership and RSAM integration
- Whether the normalized GitHub Environment names or literal COUNTRY environment names are adopted
