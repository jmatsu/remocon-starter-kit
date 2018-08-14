#!/usr/bin/env bash

set -eu

# $1 should be project name

SERVICE_ACCOUNT_JSON_PATH="$REMOCON_PREFIX/$REMOCON_FIREBASE_PROJECT_ID/service-account.json"

case "$REMOCON_FIREBASE_PROJECT_ID" in
    "<edit here>")
        echo "<edit here> the content of service account json" > "$SERVICE_ACCOUNT_JSON_PATH"
esac

echo "$SERVICE_ACCOUNT_JSON_PATH"