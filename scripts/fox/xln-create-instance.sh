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

if [[ -z "${XILUTION_API_CLIENT_ID}" ]]; then
  echo "XILUTION_API_CLIENT_ID not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_API_CLIENT_SECRET}" ]]; then
  echo "XILUTION_API_CLIENT_SECRET not found in .env"
  exit 1
fi

if [[ -z "${1}" ]]; then
  echo "docker_hub_account is required"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
user_id=${XILUTION_ACCOUNT_USER_ID}
client_id=${XILUTION_API_CLIENT_ID}
client_secret=${XILUTION_API_CLIENT_SECRET}
docker_hub_account=${1}

post_response=$(curl -sSL -D - \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"instance\",
    \"name\": \"xilution-graphql-backend-example\",
    \"organizationId\": \"${sub_organization_id}\",
    \"containerPort\": \"3123\",
    \"environment\": [
      {
        \"name\": \"XILUTION_API_CLIENT_ID\",
        \"value\": \"${client_id}\"
      },
      {
        \"name\": \"XILUTION_API_CLIENT_SECRET\",
        \"value\": \"${client_secret}\"
      },
      {
        \"name\": \"XILUTION_SUB_ORGANIZATION_ID\",
        \"value\": \"${sub_organization_id}\"
      }
    ],
    \"image\": \"${docker_hub_account}/xilution-graphql-backend-example\",
    \"owningUserId\": \"${user_id}\",
    \"stack\": \"SMALL_STACK\"
  }" \
  "https://${environment}.fox.integration.api.xilution.com/organizations/${sub_organization_id}/instances" \
  -o /dev/null)

url=$(echo "${post_response}" | awk '/^location:/ {print $2;}')
url=${url%$'\r'}

get_response=$(curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "${url}")

echo "${get_response}" | jq "{fox_instance_id: .id, instance_name: .name}"

fox_instance_id=$(echo "${get_response}" | jq -r ".id")

update_environment_variable XILUTION_FOX_INSTANCE_ID "${fox_instance_id}"

echo "All Done! Wrote env variables to .env."
