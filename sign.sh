#/usr/bin/env bash

set -u
set -e

WORKDIR="/apks"
APKSIGNER_PATH="/usr/local/android-sdk-linux/build-tools/30.0.2/apksigner"

function handle_error {
    status=$?
    last_call=$1

    # 127 is 'command not found'
    (( status != 127 )) && return

    echo "Error on invoking: $last_call"
    return
}


trap 'handle_error "$_"' ERR


echo "$KEYSTORE_CRT" | base64 -d > /root/keystore.keystore

cd "$WORKDIR"

find "$WORKDIR" -name '*unsigned*.apk'| while read f; do

  UNSIGNED_FNAME="$(basename $f)"
  SIGNED_FNAME="$(basename $f |sed 's/unsigned/signed/g')"
  
  echo "Signing $UNSIGNED_FNAME"
  echo "Will produce $SIGNED_FNAME"
  
  $APKSIGNER_PATH sign --ks /root/keystore.keystore --ks-pass "pass:$KEYSTORE_PASSPHR" --out "$SIGNED_FNAME" "$UNSIGNED_FNAME"
done

rm -f /root/keystore.keystore

ls $WORKDIR
