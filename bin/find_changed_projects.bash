#!/usr/bin/env bash

set -eu

base_branch_name() {
    local -r url="https://api.github.com/repos"\
        "/$CIRCLE_PROJECT_USERNAME"\
        "/$CIRCLE_PROJECT_REPONAME/pulls"
        "/$(basename $CIRCLE_PULL_REQUEST)"

    curl -H "Authorization: token $GH_TOKEN" "$url" | jq '.base.ref' || exit 1
}

: "${GH_TOKEN:=$YOUR_CUSTOM_ENV_NAME}"

BRANCH_NAME="$(base_branch_name)"

git fetch origin "$BRANCH_NAME" >/dev/null

git diff --name-only "$BRANCH_NAME" -- "$REMOCON_PREFIX" | awk -F/ '$0=$2' | uniq