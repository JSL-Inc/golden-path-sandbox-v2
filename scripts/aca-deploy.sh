#!/usr/bin/env bash
set -euo pipefail

action="${1:?Expected stage or promote}"
environment="${2:?Environment is required}"
artifact_directory="${3:?Artifact directory is required}"
: "${AZURE_CONTAINER_APP_NAME:?Set AZURE_CONTAINER_APP_NAME on the GitHub environment}"
: "${AZURE_RESOURCE_GROUP:?Set AZURE_RESOURCE_GROUP on the GitHub environment}"

descriptor="$artifact_directory/deployment-metadata.json"
test -s "$descriptor"
image_reference="$(jq -er '.imageReference | select(test("^[^[:space:]]+@sha256:[0-9a-f]{64}$"))' "$descriptor")"

az config set extension.use_dynamic_install=yes_without_prompt >/dev/null
app_json="$(az containerapp show \
  --name "$AZURE_CONTAINER_APP_NAME" \
  --resource-group "$AZURE_RESOURCE_GROUP" --output json)"
mode="$(jq -r '.properties.configuration.activeRevisionsMode // empty' <<< "$app_json")"
if [[ "${mode,,}" != "labels" ]]; then
  echo "::error::Pre-provision the Container App with deployment labels mode."
  exit 1
fi
fqdn="$(jq -r '.properties.configuration.ingress.fqdn // empty' <<< "$app_json")"
if [[ "$fqdn" != "$AZURE_CONTAINER_APP_NAME".* ]]; then
  echo "::error::The Container App must have an ingress FQDN."
  exit 1
fi
domain="${fqdn#*.}"

# Read labels from the app document passed on stdin, avoiding a guessed revision.
label_revision() {
  jq -r --arg label "$1" \
    '[.properties.configuration.ingress.traffic[]? |
      select(.label == $label) | .revisionName] | first // empty' <<< "$2"
}

main_revision="$(label_revision main "$app_json")"
if [[ -z "$main_revision" ]]; then
  echo "::error::Bootstrap a main revision label before running CD."
  exit 1
fi

case "$action" in
  stage)
    az containerapp update \
      --name "$AZURE_CONTAINER_APP_NAME" \
      --resource-group "$AZURE_RESOURCE_GROUP" \
      --image "$image_reference" \
      --target-label staging --output none
    label=staging
    ;;
  promote)
    label=staging
    ;;
  *)
    echo "::error::Unknown action: $action"
    exit 1
    ;;
esac

# Azure may take a short time to report the new revision and activate its URL.
revision=""
for attempt in {1..30}; do
  app_json="$(az containerapp show \
    --name "$AZURE_CONTAINER_APP_NAME" \
    --resource-group "$AZURE_RESOURCE_GROUP" --output json)"
  revision="$(label_revision "$label" "$app_json")"
  if [[ -n "$revision" ]]; then
    actual_image="$(az containerapp revision show \
      --name "$AZURE_CONTAINER_APP_NAME" \
      --resource-group "$AZURE_RESOURCE_GROUP" \
      --revision "$revision" \
      --query 'properties.template.containers[0].image' --output tsv)"
    if [[ "$actual_image" == "$image_reference" ]]; then
      break
    fi
  fi
  sleep 5
done

if [[ -z "$revision" || "${actual_image:-}" != "$image_reference" ]]; then
  echo "::error::The staging label does not point to the artifact image."
  exit 1
fi

if [[ "$action" == "promote" ]]; then
  az containerapp revision label swap \
    --name "$AZURE_CONTAINER_APP_NAME" \
    --resource-group "$AZURE_RESOURCE_GROUP" \
    --source staging --target main --output none
  label=main
fi

url="https://${AZURE_CONTAINER_APP_NAME}---${label}.${domain}"
if [[ "$action" == "stage" ]]; then
  # A failed staging health check prevents the later promotion job.
  for attempt in {1..30}; do
    if curl --fail --silent --show-error --max-time 5 "$url/health" >/dev/null 2>&1; then
      break
    fi
    sleep 5
  done
  curl --fail --silent --show-error --max-time 10 "$url/health" >/dev/null
fi
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "application_url=$url" >> "$GITHUB_OUTPUT"
fi
echo "$environment $action: $image_reference at $url"
