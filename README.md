# Golden Path Sandbox v2

Runnable demonstration application for the centralized golden-path proof of
concept. The files in `.github/workflows` are thin event callers; the reusable
jobs and gates are maintained in
`JSL-Inc/golden-path-workflows-v2`.

## Included controls

- Branch flow: `main → release → feature → develop`
- Pull requests for `develop → feature → release → main`
- Automatic `f###` traceability tag when a feature PR merges into a release branch
- Hotfix flow: `main → hotfix → main → release → feature`
- JUnit XML test evidence
- Cobertura XML line coverage
- Blocking 80% coverage baseline with an approved transition mode
- Architecture-aligned build, testing, deployment, and gate order
- Blocking build and code-quality checks
- GitHub-native CodeQL, code-quality, coverage, dependency, and secret controls
  enforced through repository settings and rulesets
- OWASP ZAP DAST against non-production targets
- Build-once artifact promotion through `eint1`–`eint6`, `eqa`, `epreprod`, and `prod`
- Semantic versioning and verified release creation
- Production verification and rollback guidance
- API-ready ruleset and environment specifications

The calculator function is demonstration application code. Pipeline adoption
does not require changing that function; the workflow contract is implemented
by the files in `scripts`, `testing`, `.zap`, and `.github`.

## Quick start

```bash
python -m pip install -r requirements.txt
bash scripts/unit-test.sh
bash scripts/build.sh
ruff check testing
```

## Automatic demonstration flow

1. Create `release-eqa-poc-release` from `main`.
2. Create `feature-eint1-f26` from the release branch.
3. Create `develop-s34` from the feature branch.
4. Push application changes; the branch pipeline creates test evidence and an artifact.
5. Promote with PRs through `develop → feature → release → main`.
6. Merging `feature-eint1-f26` into the release branch automatically tags that release-branch merge commit as `f26`.
7. Feature validation automatically deploys to its named EINT environment.
8. A `release-eqa-*` branch deploys to EQA. A `release-epreprod-*` branch deploys to EQA first and then promotes the same artifact through ePreProd.
9. Add exactly one `major`, `minor`, or `patch` label to the PR entering `main`.
10. The merge promotes the successful release-branch artifact to production; it does not rebuild it.
11. After production deployment, smoke testing, and verification succeed, the matching SemVer tag and GitHub Release are created automatically.

Normal pushes do not also start a second PR copy of core CI. PR events run only
policy and quality checks. GitHub only discovers workflow callers directly
under `.github/workflows`.

See [docs/standards.md](docs/standards.md), [docs/control-matrix.md](docs/control-matrix.md), and [docs/demo-plan.md](docs/demo-plan.md).

## Azure Container Apps MVP

The CI caller builds a Python image with Paketo after unit and lint checks,
pushes it to ACR (the registry for this MVP), and uploads a descriptor
containing the image digest. CD downloads
that descriptor from the successful source CI run. A release merged to `main`
uses the validated release image without rebuilding it.

The branch route picks a GitHub environment and its app settings:

| Branch | App settings from | Checks after deployment |
| --- | --- | --- |
| `feature-eint1-f*` through `feature-eint6-f*` | Matching `eint1`–`eint6` environment | Integration, regression, INT Gate |
| `release-eqa-*` or `hotfix-eqa-*` | `eqa` | Integration, regression, smoke, DAST, QA Gate |
| `release-epreprod-*` or `hotfix-epreprod-*` | `eqa`, then `epreprod` after QA Gate | QA Gate, then ePreProd checks and gate |
| `main` | `prod` | Smoke, production verification, release |

For each environment, `aca-deploy.sh` creates the app if absent, or enables
ingress on the existing app. It makes sure there is a `main` revision label,
updates the image on `staging`, swaps `staging` and `main`, then reports the
app URL. The existing checks and gates run after this deploy step, as in the
GitLab example. A failing check blocks the next pipeline stage but does not
automatically roll back the label swap.

The CI and CD callers reference `@v1.0.4a`. Configure these values in GitHub
settings rather than committing their values:

| Reusable CI input | Application repository variable | Purpose |
| --- | --- | --- |
| `acr_name` | `ACR_NAME` | Existing ACR name without `.azurecr.io` |
| `image_repository` | `ACR_IMAGE_REPOSITORY` | Application repository path, such as `dcoe/gh-poc` |
| `pack_image` | `PACK_IMAGE` | Full approved pack CLI image reference in ACR |
| `paketo_builder_image` | `PAKETO_BUILDER_IMAGE` | Full approved Paketo builder image reference in ACR |
| `paketo_run_image` | `PAKETO_RUN_IMAGE` | Optional full ACR runtime image reference; blank uses the builder default |

```yaml
with:
  artifact_type: container
  acr_name: ${{ vars.ACR_NAME }}
  image_repository: ${{ vars.ACR_IMAGE_REPOSITORY }}
  pack_image: ${{ vars.PACK_IMAGE }}
  paketo_builder_image: ${{ vars.PAKETO_BUILDER_IMAGE }}
  paketo_run_image: ${{ vars.PAKETO_RUN_IMAGE }}
  container_build_command: bash scripts/aca-build.sh
secrets: inherit
```

The shared CI workflow receives image settings through inputs rather than
reading application variables directly. The caller can pass repository
variables or literal image references. The Paketo sample requires pack and
builder images; these inputs default to blank so package and Dockerfile
callers do not need them. All tooling and runtime images must come from ACR.
If the run-image override is blank, the approved builder's default runtime
must reference an image in ACR; otherwise set `PAKETO_RUN_IMAGE`.
No image reference or credential specific to an organization is embedded here.

| Scope | Names | Purpose |
| --- | --- | --- |
| Repository secrets | `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` | Federated service principal IDs for CI image publishing |
| GitHub environment secrets | `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` | Federated service principal IDs for each deployment target |
| GitHub environment variables | `AZURE_CONTAINER_APP_NAME`, `AZURE_RESOURCE_GROUP`, `ACA_ENVIRONMENT`, `ACA_UAMI_RESOURCE_ID` | App name, resource group, existing ACA managed environment and pull identity for each target |
| Optional GitHub environment variables | `ACA_CPU`, `ACA_MEMORY`, `ACA_TARGET_PORT`, `ACA_STARTUP_COMMAND` | Defaults: `0.5`, `1Gi`, `8080`, `/cnb/process/web` |

Azure login uses a service principal with GitHub OIDC federation, matching
the GitLab federated-token approach. Store these three Actions secrets in the
application repository for CI: `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, and
`AZURE_SUBSCRIPTION_ID`. Set the same secret names in each deployment
environment (`eint1`–`eint6`, `eqa`, `epreprod`, `prod`) for CD. Use
the ACR subscription ID for CI and the target ACA subscription ID for CD.
Environment secrets override repository secrets; set all three explicitly
for each target to avoid falling back to CI values.

No client secret or `AZURE_CREDENTIALS` JSON is used. Both callers and reusable
workflows grant `id-token: write` and callers use `secrets: inherit`.
`azure/login@v2` requests the temporary token and exchanges it with Azure.
The subsequent `az acr login --name "$ACR_NAME"` in CI authenticates Docker
to ACR using that Azure session.

The cloud team must configure the service principal's Azure federated
credentials to trust the application/caller repository, not just this shared
workflow repository. The issuer is `https://token.actions.githubusercontent.com`
and the audience is `api://AzureADTokenExchange`. CI has no GitHub environment,
so its publishing push jobs use branch-based subjects: configure trust for
the permitted feature, release, and hotfix branches, using exact credentials
or an approved flexible credential. CD uses the selected GitHub environment's
subject, including a separate `epreprod` deployment job. Match the actual
OIDC subject format emitted by the repository, including immutable repository
and owner IDs if enabled. Environment deployment rules should restrict which
branches can deploy to each target. This repository change does not create
Azure federated credentials or assign Azure permissions.

CI needs ACR push/pull access; ACA's managed identity needs pull access.
The CD principal needs target app management and permission to assign the
configured user-assigned identity. Never commit identity values or tokens.

`ACA_ENVIRONMENT` is the Azure managed environment name, not the GitHub
environment name. `IMAGE_TAG`, digest/reference metadata, and `GITHUB_OUTPUT`
are supplied by the pipeline; do not configure them as variables.

Set distinct app and resource group values for each environment if those
deployments must be isolated. Provision the ACA managed environments and
user-assigned identities in Azure, grant the app identity pull access to ACR,
and grant the deployment service principal permission to create or update its
target apps and assign the configured user-assigned identity. Grant the CI
service principal push access to ACR. The app's
`ACA_UAMI_RESOURCE_ID` is its registry pull identity, separate from the
service principal used by GitHub Actions. Smoke checks need the deployed
app URL's `/health` to be reachable. Store app settings and credentials in
Azure or GitHub environment configuration.

The existing integration and regression scripts are demonstration checks, and
the DAST job validates the ZAP policy file only. Replace them with real
application checks before relying on the gates for production assurance.
Application-specific OpenTelemetry variables, internal CA bindings, and Python
package mirror settings from the GitLab example are left for the adopting app;
no organization endpoint or credential is embedded here. A failed deployment
or post-deploy check requires an operator to restore the previous revision if
needed.
