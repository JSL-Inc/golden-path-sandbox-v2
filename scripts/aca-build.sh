#!/usr/bin/env bash
set -euo pipefail

: "${IMAGE_TAG:?CI must supply IMAGE_TAG}"
: "${PACK_IMAGE:?Set PACK_IMAGE to an approved pack CLI image in ACR}"
: "${PAKETO_BUILDER_IMAGE:?Set PAKETO_BUILDER_IMAGE to an approved Paketo builder in ACR}"
: "${PAKETO_RUN_IMAGE:?Set PAKETO_RUN_IMAGE to an approved Paketo run image in ACR}"
: "${ACR_NAME:?CI must supply ACR_NAME}"
: "${GITHUB_OUTPUT:?CI must supply GITHUB_OUTPUT}"

registry_server="${ACR_NAME}.azurecr.io"
for image in "$PACK_IMAGE" "$PAKETO_BUILDER_IMAGE" "$PAKETO_RUN_IMAGE"; do
  if [[ "$image" != "$registry_server/"* ]]; then
    echo "::error::Tooling and builder images must be mirrored in the configured ACR."
    exit 1
  fi
done

# Azure login and az acr login run in the reusable CI workflow before this script.
docker run --rm --pull always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD:/workspace:ro" \
  -v "$HOME/.docker/config.json:/root/.docker/config.json:ro" \
  "$PACK_IMAGE" build "$IMAGE_TAG" \
    --path /workspace \
    --builder "$PAKETO_BUILDER_IMAGE" \
    --run-image "$PAKETO_RUN_IMAGE" \
    --pull-policy always \
    --publish

for attempt in {1..12}; do
  digest="$(az acr manifest show-metadata \
    --registry "$ACR_NAME" \
    --name "${IMAGE_TAG#*/}" \
    --query digest --output tsv 2>/dev/null || true)"
  if [[ "$digest" =~ ^sha256:[0-9a-f]{64}$ ]]; then
    echo "digest=$digest" >> "$GITHUB_OUTPUT"
    echo "Published $IMAGE_TAG@$digest"
    exit 0
  fi
  sleep 5
done

echo "::error::ACR did not return a digest for the published image."
exit 1
