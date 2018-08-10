#!/usr/bin/env bash

set -eu

curl -s --compressed -IXGET \
  -H "Authorization: Bearer $REMOCON_FIREBASE_ACCESS_TOKEN" \
  "https://firebaseremoteconfig.googleapis.com/v1/projects/$1/remoteConfig" | \
  grep "[eE]tag" | awk '$0=$2'
