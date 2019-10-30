#!/usr/bin/env bash

set -e

. ./scripts/common-functions.sh

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_ACCESS_TOKEN}" ]]; then
  echo "XILUTION_ACCOUNT_ACCESS_TOKEN not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_USER_ID}" ]]; then
  echo "XILUTION_ACCOUNT_USER_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_API_USER_ID}" ]]; then
  echo "XILUTION_API_USER_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
account_user_id=${XILUTION_ACCOUNT_USER_ID}
api_user_id=${XILUTION_API_USER_ID}

post_response=$(curl -sSL -D - \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"client\",
    \"name\": \"API Client\",
    \"grants\": [\"client_credentials\"],
    \"redirectUris\": [],
    \"organizationId\": \"${sub_organization_id}\",
    \"clientUserId\": \"${api_user_id}\",
    \"owningUserId\": \"${account_user_id}\",
    \"active\": true
  }" \
  "https://${environment}.hippo.basics.api.xilution.com/organizations/${sub_organization_id}/clients" \
  -o /dev/null)

url=$(echo "${post_response}" | awk '/^location:/ {print $2;}')
url=${url%$'\r'}

get_response=$(curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "${url}")

echo "${get_response}" | jq "{client_id: .id, client_name: .name, client_secret: .secret}"

xilution_client_id=$(echo "${get_response}" | jq -r ".id")
xilution_client_secret=$(echo "${get_response}" | jq -r ".secret")

update_environment_variable XILUTION_API_CLIENT_ID "${xilution_client_id}"
update_environment_variable XILUTION_API_CLIENT_SECRET "${xilution_client_secret}"

echo "All Done! Wrote env variables to .env."
