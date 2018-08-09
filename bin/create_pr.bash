#!/usr/bin/env bash

create_pr() {
  local -r api_url="https://api.github.com/repos"\
                   "/$CIRCLE_PROJECT_USERNAME"\
                   "/$CIRCLE_PROJECT_REPONAME/pulls"

  local -r branch_name="$1"
  local body=("\"head\": \"$branch_name\"", \
              "\"base\": \"$CIRCLE_BRANCH\"", \
              "\"title\": \"Update via CI\"")
  local json_body="{${body[*]}}"

  curl -s -H "Authorization: token ${GH_TOKEN}" \
      -H "Content-Type: application/json" \
      -d "${json_body}" "$api_url" || :
}

: "${GH_TOKEN:=$YOUR_CUSTOM_ENV_NAME}"

create_pr "$(git rev-parse --abbrev-ref HEAD)"