#!/usr/bin/env bash
set -euo pipefail

action="${1:?Expected stage or promote}"
environment="${2:?Environment is required}"
artifact_dir="${3:?Artifact directory is required}"
app="${AZURE_CONTAINER_APP_NAME:?Set AZURE_CONTAINER_APP_NAME}"
group="${AZURE_RESOURCE_GROUP:?Set AZURE_RESOURCE_GROUP}"
image="$(jq -er .imageReference "$artifact_dir/deployment-metadata.json")"

az config set extension.use_dynamic_install=yes_without_prompt >/dev/null

case "$action" in
  stage)
    az containerapp update --name "$app" --resource-group "$group" \
      --image "$image" --target-label staging --output none
    label=staging
    ;;
  promote)
    revision="$(az containerapp show --name "$app" --resource-group "$group" \
      --query "properties.configuration.ingress.traffic[?label=='staging'].revisionName | [0]" --output tsv)"
    test -n "$revision" || { echo "::error::No staging revision found."; exit 1; }
    staged_image="$(az containerapp revision show --name "$app" --resource-group "$group" \
      --revision "$revision" --query 'properties.template.containers[0].image' --output tsv)"
    test "$staged_image" = "$image" || { echo "::error::Staging image differs from the CI artifact."; exit 1; }
    az containerapp revision label swap --name "$app" --resource-group "$group" \
      --source staging --target main --output none
    label=main
    ;;
  *)
    echo "::error::Expected stage or promote."
    exit 1
    ;;
esac

fqdn="$(az containerapp show --name "$app" --resource-group "$group" \
  --query properties.configuration.ingress.fqdn --output tsv)"
test -n "$fqdn" || { echo "::error::Container App ingress FQDN is missing."; exit 1; }
url="https://${app}---${label}.${fqdn#*.}"

if [[ "$action" == "stage" ]]; then
  curl --fail --silent --show-error --retry 15 --retry-all-errors \
    --retry-delay 3 --max-time 10 "$url/health" >/dev/null
fi

echo "application_url=$url" >> "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"
echo "$environment $action: $image at $url"
