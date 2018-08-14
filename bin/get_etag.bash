#!/usr/bin/env bash

set -eu

curl -s --compressed -IXGET \
  -H "Authorization: Bearer $REMOCON_FIREBASE_ACCESS_TOKEN" \
  "https://firebaseremoteconfig.googleapis.com/v1/projects/$REMOCON_FIREBASE_PROJECT_ID/remoteConfig" | \
  grep "[eE]tag" | awk '$0=$2'
