# POC demonstration plan

1. Show the four v2 repositories and responsibility split.
2. Create `develop-s34` from `feature-eint1-f26`.
3. Change application code and tests.
4. Open a PR into `feature-eint1-f26` using the template.
5. Demonstrate a failing test blocking Standard CI.
6. Fix the test and show JUnit XML, Cobertura XML, and 80% enforcement.
7. Obtain the required approval and squash merge.
8. Promote feature to `release-eqa-poc-release`.
9. Run integration and regression workflows.
10. Promote release to `main`.
11. Show the `major`, `minor`, or `patch` PR label validated by the PR-policy check.
12. Calculate the semantic version.
13. Show the immutable artifact from the CI run.
14. Promote the artifact through Integration and QA.
15. Show environment approval for Production.
16. Run production verification and retain its evidence artifact.
17. Supply that successful verification run ID to create the final tag and GitHub Release.
18. Show CodeQL/dependency evidence and advisory DAST output.
19. Demonstrate hotfix synchronization back through release and feature.

## Acceptance

- Direct updates to protected branches are blocked
- Pull requests and required checks are enforced
- Test or coverage failure blocks merge
- JUnit and Cobertura evidence is retained
- Build output is promoted without rebuilding
- Production requires protected-environment approval
- Release is created only after production verification
- Optional controls can be enabled without restructuring the core solution
