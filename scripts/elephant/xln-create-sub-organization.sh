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

if [[ -z "${XILUTION_ACCOUNT_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_ACCOUNT_ORGANIZATION_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_ACCOUNT_USER_ID}" ]]; then
  echo "XILUTION_ACCOUNT_USER_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
organization_id=${XILUTION_ACCOUNT_ORGANIZATION_ID}
user_id=${XILUTION_ACCOUNT_USER_ID}

post_response=$(curl -sSL -D - \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"organization\",
    \"name\": \"graphql-backend-example-sub-organization\",
    \"organizationId\": \"${organization_id}\",
    \"owningUserId\": \"${user_id}\",
    \"active\": true
  }" \
  "https://${environment}.elephant.basics.api.xilution.com/organizations" \
  -o /dev/null)

url=$(echo "${post_response}" | awk '/^location:/ {print $2;}')
url=${url%$'\r'}

get_response=$(curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "${url}")

echo "${get_response}" | jq "{organization_id: .id, organization_name: .name}"

xilution_sub_organization_id=$(echo "${get_response}" | jq -r ".id")

update_environment_variable XILUTION_SUB_ORGANIZATION_ID "${xilution_sub_organization_id}"

echo "All Done! Wrote env variables to .env."
