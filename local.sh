#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_CRYPT_VERSION=$(curl -sSL https://api.github.com/repos/AGWA/git-crypt/tags | jq -r "[.[].name | select(contains(\"debian\") | not)] | .[0]")
echo "Using git-crypt version ${GIT_VERSION}"

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_VERSION="${GIT_VERSION}" \
  -f amazonlinux.Dockerfile \
  -t truemark/git-crypt:beta-${GIT_VERSION} \
  -t truemark/git-crypt:beta \
  .
IMAGE="truemark/git-crypt:beta-${GIT_VERSION}" ARCH="amd64" FILE="git-crypt-${GIT_VERSION}-linux-amd64.tar" ./getlayer.sh
IMAGE="truemark/git-crypt:beta-${GIT_VERSION}" ARCH="arm64" FILE="git-crypt-${GIT_VERSION}-linux-arm64.tar" ./getlayer.sh

#docker buildx build \
##  --push \
#  --platform linux/arm64,linux/amd64 \
#  --builder beta \
#  --build-arg GIT_VERSION="${GIT_VERSION}" \
#  -f alpine.Dockerfile \
#  -t truemark/git-crypt:beta-musl-${GIT_VERSION} \
#  -t truemark/git-crypt:beta-musl \
#  .
#IMAGE="truemark/git-crypt:beta-musl-${GIT_VERSION}" ARCH="amd64" FILE="git-crypt-musl-${GIT_VERSION}-linux-amd64.tar" ./getlayer.sh
#IMAGE="truemark/git-crypt:beta-musl-${GIT_VERSION}" ARCH="arm64" FILE="git-crypt-musl-${GIT_VERSION}-linux-arm64.tar" ./getlayer.sh
