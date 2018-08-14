#!/usr/bin/env bash

set -eu

create_pr() {
  local -r url="https://api.github.com/repos/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME/pulls"

  local -r branch_name="$1" title="$2"
  local body=("\"head\": \"$branch_name\"", \
              "\"base\": \"$CIRCLE_BRANCH\"", \
              "\"title\": \"$title\"")
  local json_body="{${body[*]}}"

  curl -s -H "Authorization: token ${GH_TOKEN}" \
      -H "Content-Type: application/json" \
      -d "${json_body}" "$url" || :
}

: "${GH_TOKEN:=$YOUR_CUSTOM_ENV_NAME}" # <edit here>

create_pr "$(git rev-parse --abbrev-ref HEAD)" "$1"