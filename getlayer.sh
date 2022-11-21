#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "${0}")" || exit 1

# Cleanup
rm -rf image && mkdir -p image
docker image rm --force ${IMAGE} > /dev/null 2>&1

# Pull
docker pull -q --platform=linux/${ARCH} ${IMAGE}
docker save -o image/image.tar ${IMAGE}

# Save & Export
cd image && tar -xf image.tar
find . -name "layer.tar" -exec tar --extract --file={} --strip-components 3 usr/local/bin/git-crypt \;
mv git-crypt ../${FILE};

# Cleanup
docker image rm ${IMAGE}
cd .. && rm -rf image
