# Security strategy

## Required design controls

| Control | Implementation | POC mode |
|---|---|---|
| SAST | CodeQL `security-extended` query suite | Automated when repository/language is eligible |
| Dependency review | Blocks newly introduced high/critical vulnerable dependencies | Automated on PRs when dependency graph is available |
| Dependency alerts | Dependabot vulnerability alerts | Repository setting |
| Dependency updates | Grouped weekly pip and GitHub Actions PRs | Committed configuration |
| Secret scanning | GitHub secret scanning | Repository/organization setting |
| Push protection | GitHub push protection | Repository/organization setting |
| DAST | OWASP ZAP against non-production URL | Advisory by default; configurable blocking |

## Severity and migration treatment

- Newly introduced high/critical dependency risk is blocking when the platform supports dependency review.
- CodeQL findings appear in GitHub code scanning; organization rules determine which severities become blocking.
- Existing findings are baselined, assigned, and remediated under an approved plan rather than silently dismissed.
- High/critical CIA applications require Security plus Product Owner/Manager/direct-leader approval before production.
- False positives and accepted risks require an owner, compensating controls, justification, and expiration.

## Secret response

1. Block or stop the push where push protection applies.
2. Revoke or rotate a real exposed credential immediately.
3. Remove it from current source and history where required.
4. Record the incident through the approved process.
5. Document test-secret or false-positive exceptions; do not normalize broad bypass.

## DAST

- Production-like non-production target only by default
- Real tab-separated `.zap/rules.tsv`
- HTML and JSON evidence retained
- Informational/warning findings are tuned before broad enforcement
- Internet-facing or high-risk applications can enable blocking after rules and ownership are approved
