#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-eu-central-1}"
ECR_REGISTRY="${ECR_REGISTRY:?set ECR_REGISTRY like 123456789.dkr.ecr.region.amazonaws.com}"
ECR_REPOSITORY="${ECR_REPOSITORY:-djangoblog}"

IMAGE="${ECR_REGISTRY}/${ECR_REPOSITORY}:snapshot"

echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"

echo "Pulling image: $IMAGE"
docker pull "$IMAGE"

echo "Running container on DEV: host 8080 -> container 4000"
docker rm -f djangoblog-dev 2>/dev/null || true
docker run -d --name djangoblog-dev \
  -p 8080:4000 \
  -e PORT=4000 \
  "$IMAGE"

echo "Done."
docker ps | grep djangoblog-dev

