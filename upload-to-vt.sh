#!/usr/bin/env bash

# ./upload-to-vt.sh apikey file
#set -x
#set -v

function usage {
    echo "USAGE: ./upload-to-vt.sh vt_api_key file_path"
}

if [ "$1" == "" ]; then
    echo "VT API KEY MISSING"
    usage
    exit 1
fi
VT_API_KEY="$1"

if [ "$2" == "" ]; then
    echo "FILE PATH REQUIRED"
    usage
    exit 1
fi
FILE_PATH="$2"

echo "Getting Upload URL"
UPLOAD_URL=$(curl --header "x-apikey: $VT_API_KEY" --header 'Accept: application/json' --header 'Content-Type: multipart/form-data' https://www.virustotal.com/api/v3/files/upload_url | jq -r '.data')
# {
#    "data": "https://www.virustotal.com/_ah/upload/AMmfu6Y3ZQIfTzhkP7ATha7AsKuOW6rBw_T8M2SXIREatJ0xJD5g_8yGAE908kAUWvlhwnC4ePZDxnzeXRsLOVVrQZSR88-qR9Dvrzt0YnguvQpfVatgt69YTI2fwSdDPkVRD5Mh006P5jsNZ8gN545q7GudKmpgysips-YUTBqpEPq20fbs2nTeDPhRd2yXli0wRzaWOybwee1FVXU1r6akWuNMdcJgccAc3m5HXUpvkbXYw2w2vbuShT7FkgHJCEDJNG2NdpLElKUh9tTRii35wUTTKhJF1NZ_KTZwEk6qFA4hjFMgu-Y4Dteglfg-NQmpsQpEoxiDKTpKlam9YDzQsjcX1y3Tg6lwXyN9_sIidPvQp_dFKjZvkBAwVUPpC71c5uzyeb4-qwXVjB_NU1gwUj8Hp8BvXKH3Nj0btFpE3MpDkbaOpPgRB6z94lc2w9Qp-WZ58B7MrigY_xJar5H29STQ_YNQUVu4rdx4SD2Ma9SY5qadGBtN7o1ewTSNaglJculkHbU3BvL44afoacWOrZ3TVVYPWthslZLAsB1JsiNnouqnPMU2K8YMfJzwZUyzBTSIdUUXsh6kIHDfU0_bhsdq2mmEzih9AB8ihwjHMQRHoMZO3Yz76L-61FVFHVJvOdDB1RKUMTIAt5LdETv15CjRxrM3oStVZKM87N9AFpczO_iblVMDvhPbzfmEsZkViy2frFpzDOifs19YU1e5YcCvnGfA0A_ik6AU7tAatwLmJYhVDYWIhN4DMcq4aWPaZ__6t3dYCoFJUZPAyZdnszoqUNdnrVYyBoMLI6R4JAvxnyrVo2NiC6QXipDYSKi7W2SabGh2LN2Xit_SZg9oAvCQmGaKKqImBErtRa5LV-eWCClE41PMKPjzBN1yNE0_3TWg8HxtaVk8UXKzoEtm0DxFTRoKmKu8oV0s7_oRarpn6kfuAVLTm3VBEWU3Z9Mg0GdlGlfCUTPt9ZhfHf25gmlnKreS9GMWf_cdpbWZ14x-OLry5y5ZX5Yy09onDfLRAmmY2Djs/ALBNUaYAAAAAYcXd7VwoACaEA7PSHOMMIa-hmqFa2YW9/"
# }

ANALYSIS_ID=$(curl -XPOST --header "x-apikey: $VT_API_KEY" --header 'Accept: application/json' --header 'Content-Type: multipart/form-data' -F "file=@$FILE_PATH" $UPLOAD_URL | jq -r '.data.id')

# {
#     "data": {
#         "type": "analysis",
#         "id": "Y2Y2NDJlOGUxYTlhNTAyYWZhMGZkNDRmOGQzYjdjNWQ6MTY0MDM1NzY5OQ=="
#     }
# }

echo "ANALYSIS:"
echo "  analyzed file: $FILE_PATH"
echo "   analysis URL: https://www.virustotal.com/gui/file-analysis/$ANALYSIS_ID"