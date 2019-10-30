#!/usr/bin/env bash

set -e

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_UI_CLIENT_ID}" ]]; then
  echo "XILUTION_UI_CLIENT_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
client_id=${XILUTION_UI_CLIENT_ID}
read -r username
echo -n Password:
read -rs password
echo

curl -s \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password&client_id=${client_id}&username=${username}&password=${password}&scope=read write" \
  "https://${environment}.zebra.basics.api.xilution.com/organizations/${sub_organization_id}/oauth/token" |
  jq "{ access_token: .access_token, user_id: .user.id }"
