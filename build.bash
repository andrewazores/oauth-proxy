#!/usr/bin/env bash

set -xe

DIR="$(dirname "$(readlink -f "$0")")"

IMAGE_NAMESPACE="${IMAGE_NAMESPACE:-quay.io/cryostat}"
IMAGE_NAME="${IMAGE_NAME:-openshift-oauth-proxy}"

podman build -f "${DIR}/Containerfile" . -t "${IMAGE_NAMESPACE}/${IMAGE_NAME}:latest"

for tag in $IMAGE_TAGS; do
    podman tag "${IMAGE_NAMESPACE}/${IMAGE_NAME}:latest" "${IMAGE_NAMESPACE}/${IMAGE_NAME}:${tag}"
done
