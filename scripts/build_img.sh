#!/usr/bin/env bash

cd ./deps/pi-gen
./build-docker.sh

LS=`ls ./deploy/*.zip 2>/dev/null`
if [ "$?" != "0" ]; then
  echo "******** Failed to build image files... ********"
  exit 1
fi
