#!/usr/bin/env bash

set -eu

# $1 should be project name

SERVICE_ACCOUNT_JSON_PATH="service-account.json"

case "$1" in
    "your project name")
        echo "<your account json file>" > "$SERVICE_ACCOUNT_JSON_PATH"
esac

echo "$SERVICE_ACCOUNT_JSON_PATH"