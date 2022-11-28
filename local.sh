#/usr/bin/env bash

# This script is only intended to be used for local development on this project.
# It depends on a buildx node called "beta. You can create such an environment
# by executing "docker buildx create --name beta"

set -euo pipefail

export GIT_CRYPT_VERSION=$(curl -sSL https://api.github.com/repos/AGWA/git-crypt/tags | jq -r "[.[].name | select(contains(\"debian\") | not)] | .[0]")
echo "Using git-crypt version ${GIT_CRYPT_VERSION}"

docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f alpine-3.16.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f alpine-3.17.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f amazonlinux-2.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f amazonlinux-2022.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f ubuntu-focal.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f ubuntu-jammy.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f debian-buster.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f debian-bullseye.Dockerfile .
docker build -t moo --build-arg GIT_CRYPT_VERSION=$GIT_CRYPT_VERSION -f debian-bookworm.Dockerfile .
