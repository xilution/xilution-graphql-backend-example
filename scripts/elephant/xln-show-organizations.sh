#!/usr/bin/env bash

set -e

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_ACCESS_TOKEN}" ]]; then
  echo "XILUTION_ACCOUNT_ACCESS_TOKEN not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}

curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "https://${environment}.elephant.basics.api.xilution.com/organizations?page-number=0&page-size=10" |
  jq '.content | if (. | length > 0) then (.[] | {id: .id, name: .name}) else "No organizations found." end'
