#!/usr/bin/env bash
set -euo pipefail

environment="${1:?Environment is required}"
artifact_dir="${2:?Artifact directory is required}"
app="${AZURE_CONTAINER_APP_NAME:?Set AZURE_CONTAINER_APP_NAME}"
group="${AZURE_RESOURCE_GROUP:?Set AZURE_RESOURCE_GROUP}"
aca_environment="${ACA_ENVIRONMENT:?Set ACA_ENVIRONMENT}"
identity="${ACA_UAMI_RESOURCE_ID:?Set ACA_UAMI_RESOURCE_ID}"
image="$(jq -er .imageReference "$artifact_dir/deployment-metadata.json")"
registry="${image%%/*}"
port="${ACA_TARGET_PORT:-8080}"
startup="${ACA_STARTUP_COMMAND:-/cnb/process/web}"
cpu="${ACA_CPU:-0.5}"
memory="${ACA_MEMORY:-1Gi}"

az extension add --name containerapp --upgrade --only-show-errors

echo "Azure tooling versions:"
az version
az extension show --name containerapp --query version --output tsv

# Azure can return before the new revision is ready and its label is assigned.
wait_for_label() {
  local label="$1" revision="${2:?Azure did not return a revision name}"
  for attempt in {1..60}; do
    if az containerapp show --name "$app" --resource-group "$group" \
      --query 'properties.{ready:latestReadyRevisionName,traffic:configuration.ingress.traffic}' \
      --output json | jq -e --arg label "$label" --arg revision "$revision" \
      '.ready == $revision and any(.traffic[]?; .label == $label and .revisionName == $revision)' >/dev/null; then
      return 0
    fi
    echo "Waiting for $label to point to ready revision $revision ($attempt/60)"
    sleep 5
  done
  echo "::error::Timed out waiting for label $label on revision $revision."
  az containerapp revision show --name "$app" --resource-group "$group" \
    --revision "$revision" \
    --query 'properties.{provisioning:provisioningState,health:healthState,running:runningState,details:runningStateDetails}' \
    --output json
  return 1
}

if az containerapp show --name "$app" --resource-group "$group" >/dev/null 2>&1; then
  az containerapp ingress enable --name "$app" --resource-group "$group" \
    --type external --target-port "$port"
else
  created_revision="$(az containerapp create --name "$app" --resource-group "$group" \
    --environment "$aca_environment" --image "$image" --command "$startup" \
    --registry-server "$registry" --registry-identity "$identity" \
    --user-assigned "$identity" --cpu "$cpu" --memory "$memory" \
    --ingress external --target-port "$port" --revisions-mode labels --target-label main \
    --query properties.latestRevisionName --output tsv)"
  wait_for_label main "$created_revision"
fi

echo "Container App state before main-label initialization:"
az containerapp show --name "$app" --resource-group "$group" \
  --query 'properties.{mode:configuration.activeRevisionsMode,targetLabel:configuration.targetLabel,traffic:configuration.ingress.traffic}' \
  --output json

main_revision="$(az containerapp show --name "$app" --resource-group "$group" \
  --query "properties.configuration.ingress.traffic[?label=='main'].revisionName | [0]" --output tsv)"
if [[ -z "$main_revision" || "$main_revision" == "None" ]]; then
  latest_revision="$(az containerapp revision list --name "$app" --resource-group "$group" \
    --query "sort_by(@, &properties.createdTime)[-1].name" --output tsv)"
  az containerapp revision label add --name "$app" --resource-group "$group" \
    --label main --revision "$latest_revision"
fi

staging_revision="$(az containerapp update --name "$app" --resource-group "$group" \
  --image "$image" --command "$startup" --cpu "$cpu" --memory "$memory" \
  --target-label staging --query properties.latestRevisionName --output tsv)"
wait_for_label staging "$staging_revision"
az containerapp revision label swap --name "$app" --resource-group "$group" \
  --source staging --target main

fqdn="$(az containerapp show --name "$app" --resource-group "$group" \
  --query properties.configuration.ingress.fqdn --output tsv)"
echo "application_url=https://$fqdn" >> "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"
echo "Deployed $image to $environment"
