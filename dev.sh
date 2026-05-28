#!/usr/bin/bash
set -euo pipefail
set -xv
rm -Rf Signal-Android/
LATEST_TAG="$(curl -s https://api.github.com/repos/signalapp/Signal-Android/tags | jq -r '.[] .name' | sed '/-/!{s/$/_/}' | sort -V | grep -v nightly | sed 's/_$//'|tail -n1)"

echo "Cloning Signal-Android (latest tag=$LATEST_TAG)"

git clone --depth 1 --recurse-submodules -b "$LATEST_TAG" https://github.com/WhisperSystems/Signal-Android
cd Signal-Android
for f in ../0000-*.patch; do echo "$f"; git apply "$f"; done
