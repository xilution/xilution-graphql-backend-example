#!/usr/bin/env bash

set -e

. ./scripts/common-functions.sh

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_API_CLIENT_ID}" ]]; then
  echo "XILUTION_API_CLIENT_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_API_CLIENT_SECRET}" ]]; then
  echo "XILUTION_API_CLIENT_SECRET not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
client_id=${XILUTION_API_CLIENT_ID}
client_secret=${XILUTION_API_CLIENT_SECRET}

response=$(curl -s \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=${client_id}&client_secret=${client_secret}&scope=read write" \
  "https://${environment}.zebra.basics.api.xilution.com/organizations/${sub_organization_id}/oauth/token")

echo "${response}" |
  jq "{ xilution_api_access_token: .access_token }"

xilution_api_access_token=$(echo "${response}" | jq -r ".access_token")

update_environment_variable XILUTION_API_ACCESS_TOKEN "${xilution_api_access_token}"

echo "All Done! Wrote env variables to .env."
