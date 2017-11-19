#!/usr/bin/env bash

if [ -z "${TAG_NAME}" ]; then
  echo "TAG_NAME is required"
  exit 1
fi

function fetch_upload_url {
  cp -f ../../scripts/release-template.json release.json
  if [ "$?" != "0" ]; then
    echo "release-template.json is missing on $(pwd)/../../scripts/"
    exit 1
  fi
  for e in TAG_NAME \
      RELEASE_NAME \
      RELEASE_DESCRIPTION; do
    sed -i -e "s/%${e}%/${!e//\//\\/}/g" release.json
  done
  rm -f release.json-e
  RESP=$(curl -sSL \
    -H "Authorization: token ${GITHUB_OAUTH_TOKEN}" \
    -d @release.json \
    "https://api.github.com/repos/${REPO}/releases")
  UPLOAD_URL=`echo ${RESP} | jq -r '.upload_url'`
  UPLOAD_URL="${UPLOAD_URL%\{*}"
}

function upload_zip_files {
  for ZIP in `ls ./deploy/*.zip`; do
    echo "Uploading [${ZIP}]..."
    FILENAME=`basename ${ZIP}`
    curl -v -s \
      -H "Authorization: token ${GITHUB_OAUTH_TOKEN}"  \
      -H "Content-Type: application/zip" \
      --data-binary @${ZIP} \
      "${UPLOAD_URL}?name=${FILENAME}"
  done
  echo "Upload done"
}

# main
cd ./deps/pi-gen
RASPBIAN_TAG=`git describe --tags HEAD`
TYPICAL_IMAGE_INFO=`ls ./deploy/*en_US.info`
BUILT_ON=${TYPICAL_IMAGE_INFO:9:10}
REPO=CANDY-LINE/candy-pi-lite-os-image
RELEASE_NAME="v${TAG_NAME}"
RELEASE_DESCRIPTION="${RELEASE_DESCRIPTION:-[${RASPBIAN_TAG}](https://github.com/RPi-Distro/pi-gen/tree/${RASPBIAN_TAG}) dedicated to [CANDY Pi Lite](https://github.com/CANDY-LINE/candy-pi-lite-service) board built on ${BUILT_ON}}"

fetch_upload_url
upload_zip_files
