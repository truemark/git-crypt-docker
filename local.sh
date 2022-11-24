#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_CRYPT_VERSION=$(curl -sSL https://api.github.com/repos/AGWA/git-crypt/tags | jq -r "[.[].name | select(contains(\"debian\") | not)] | .[0]")
echo "Using git-crypt version ${GIT_CRYPT_VERSION}"

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  -f amazonlinux.Dockerfile \
  -t truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-amazonlinux\
  -t truemark/git-crypt:beta-amazonlinux \
  .
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-amazonlinux" ARCH="amd64" FILE="git-crypt-${GIT_CRYPT_VERSION}-amazonlinux-amd64" ./getlayer.sh
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-amazonlinux" ARCH="arm64" FILE="git-crypt-${GIT_CRYPT_VERSION}-amazonlinux-arm64" ./getlayer.sh

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  -f alpine.Dockerfile \
  -t truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-alpine \
  -t truemark/git-crypt:beta-alpine \
  .
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-alpine" ARCH="amd64" FILE="git-crypt-${GIT_CRYPT_VERSION}-alpine-amd64" ./getlayer.sh
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-alpine" ARCH="arm64" FILE="git-crypt-${GIT_CRYPT_VERSION}-alpine-arm64" ./getlayer.sh

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  -f ubuntu-focal.Dockerfile \
  -t truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-focal \
  -t truemark/git-crypt:beta-ubuntu-focal \
  .
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-focal" ARCH="amd64" FILE="git-crypt-${GIT_CRYPT_VERSION}-ubuntu-focal-amd64" ./getlayer.sh
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-focal" ARCH="arm64" FILE="git-crypt-${GIT_CRYPT_VERSION}-ubuntu-focal-arm64" ./getlayer.sh

docker buildx build \
  --push \
  --platform linux/arm64,linux/amd64 \
  --builder beta \
  --build-arg GIT_CRYPT_VERSION="${GIT_CRYPT_VERSION}" \
  -f ubuntu-jammy.Dockerfile \
  -t truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-jammy \
  -t truemark/git-crypt:beta-ubuntu-jammy \
  .
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-jammy" ARCH="amd64" FILE="git-crypt-${GIT_CRYPT_VERSION}-ubuntu-jammy-amd64" ./getlayer.sh
IMAGE="truemark/git-crypt:beta-${GIT_CRYPT_VERSION}-ubuntu-jammy" ARCH="arm64" FILE="git-crypt-${GIT_CRYPT_VERSION}-ubuntu-jammy-arm64" ./getlayer.sh
