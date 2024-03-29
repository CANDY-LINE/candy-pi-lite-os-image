#!/usr/bin/env bash

if [ -z "${TAG_NAME}" ]; then
  echo "TAG_NAME is required"
  exit 1
fi

if [ -z "${GITHUB_OAUTH_TOKEN}" ]; then
  echo "GITHUB_OAUTH_TOKEN is required"
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
  RESP=$(curl -fsSL \
    -H "Authorization: token ${GITHUB_OAUTH_TOKEN}" \
    -d @release.json \
    "https://api.github.com/repos/${REPO}/releases")
  if [ "$?" != "0" ]; then
    RESP=$(curl -fsSL \
      -H "Authorization: token ${GITHUB_OAUTH_TOKEN}" \
      "https://api.github.com/repos/${REPO}/releases/tags/${TAG_NAME}")
  fi
  UPLOAD_URL=`echo ${RESP} | jq -r '.upload_url'`
  UPLOAD_URL="${UPLOAD_URL%\{*}"
}

function upload_info_files {
  for INFO in `ls ./deploy/*.info`; do
    if [[ $INFO != *"-candy-pi-lite-raspbian-lite-en_US.info" ]] && [[ $INFO != *"-candy-pi-lite-raspbian-lite-ja_JP.info" ]]; then
      continue
    fi
    echo "Uploading [${INFO}]..."
    FILENAME=`basename ${INFO}`
    curl -s \
      -H "Authorization: token ${GITHUB_OAUTH_TOKEN}"  \
      -H "Content-Type: text/plain" \
      --data-binary @${INFO} \
      "${UPLOAD_URL}?name=${FILENAME}"
  done
  echo "INFO Upload done"
}

function upload_zip_files {
  for ZIP in `ls ./deploy/*.zip`; do
    if [[ $ZIP != *"-candy-pi-lite-raspbian-lite-en_US.zip" ]] && [[ $ZIP != *"-candy-pi-lite-raspbian-lite-ja_JP.zip" ]]; then
      continue
    fi
    echo "Uploading [${ZIP}]..."
    FILENAME=`basename ${ZIP}`
    curl -s \
      -H "Authorization: token ${GITHUB_OAUTH_TOKEN}"  \
      -H "Content-Type: application/zip" \
      --data-binary @${ZIP} \
      "${UPLOAD_URL}?name=${FILENAME}"
  done
  echo "ZIP Upload done"
}

# main
cd ./deps/pi-gen
RASPBIAN_TAG=`git describe --tags HEAD`
TYPICAL_IMAGE_INFO=`ls ./deploy/*en_US.info`
BUILT_ON=${TYPICAL_IMAGE_INFO:9:10}
REPO=CANDY-LINE/candy-pi-lite-os-image
RELEASE_NAME="v${TAG_NAME}"
RELEASE_DESCRIPTION="${RELEASE_DESCRIPTION:-[${RASPBIAN_TAG}](https://github.com/RPi-Distro/pi-gen/releases/tag/${RASPBIAN_TAG}) dedicated to [CANDY Pi Lite](https://github.com/CANDY-LINE/candy-pi-lite-service) board built on ${BUILT_ON}}"

fetch_upload_url
upload_info_files
upload_zip_files
