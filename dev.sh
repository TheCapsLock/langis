#!/usr/bin/bash
set -euo pipefail
set -xv
rm -Rf Signal-Android/
LATEST_TAG="$(curl -s https://api.github.com/repos/signalapp/Signal-Android/releases  |jq -r '[.[]|select(.prerelease==false)][0].tag_name')"

echo "Cloning Signal-Android (latest tag=$LATEST_TAG)"

git clone --depth 1 --recurse-submodules -b "$LATEST_TAG" https://github.com/WhisperSystems/Signal-Android
cd Signal-Android
for f in ../0000-*.patch; do echo "$f"; git apply "$f"; done
