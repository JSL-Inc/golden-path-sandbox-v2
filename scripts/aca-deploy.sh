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

if az containerapp show --name "$app" --resource-group "$group" >/dev/null 2>&1; then
  az containerapp ingress enable --name "$app" --resource-group "$group" \
    --type external --target-port "$port"
else
  az containerapp create --name "$app" --resource-group "$group" \
    --environment "$aca_environment" --image "$image" --command "$startup" \
    --registry-server "$registry" --registry-identity "$identity" \
    --user-assigned "$identity" --cpu "$cpu" --memory "$memory" \
    --ingress external --target-port "$port" --revisions-mode labels
fi

main_revision="$(az containerapp show --name "$app" --resource-group "$group" \
  --query "properties.configuration.ingress.traffic[?label=='main'].revisionName | [0]" --output tsv)"
if [[ -z "$main_revision" || "$main_revision" == "None" ]]; then
  latest_revision="$(az containerapp revision list --name "$app" --resource-group "$group" \
    --query "sort_by(@, &properties.createdTime)[-1].name" --output tsv)"
  az containerapp revision label add --name "$app" --resource-group "$group" \
    --label main --revision "$latest_revision"
fi

az containerapp update --name "$app" --resource-group "$group" \
  --image "$image" --command "$startup" --cpu "$cpu" --memory "$memory" \
  --target-label staging
az containerapp revision label swap --name "$app" --resource-group "$group" \
  --source staging --target main

az containerapp identity assign --name "$app" --resource-group "$group" \
  --user-assigned "$identity"
az containerapp registry set --name "$app" --resource-group "$group" \
  --server "$registry" --identity "$identity"

fqdn="$(az containerapp show --name "$app" --resource-group "$group" \
  --query properties.configuration.ingress.fqdn --output tsv)"
echo "application_url=https://$fqdn" >> "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"
echo "Deployed $image to $environment"
