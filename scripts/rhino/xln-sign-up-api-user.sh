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

if [[ -z "${1}" ]]; then
  echo "email is required"
  exit 1
fi

if [[ -z "${2}" ]]; then
  echo "username is required"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
email=${1}
username=${2}
echo -n Password:
read -rs password
echo

post_response=$(curl -sSL -D - \
  -X POST \
  -H "Content-Type: application/json" \
  -d "{
    \"firstName\": \"API\",
    \"lastName\": \"User\",
    \"email\": \"${email}\",
    \"username\": \"${username}\",
    \"password\": \"${password}\"
  }" \
  "https://${environment}.rhino.basics.api.xilution.com/organizations/${sub_organization_id}/sign-up-user" \
  -o /dev/null)

url=$(echo "${post_response}" | awk '/^location:/ {print $2;}')
url=${url%$'\r'}

get_response=$(curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "${url}")

echo "${get_response}" | jq "{user_id: .id, user_first_name: .firstName, user_last_name: .lastName}"

xilution_user_id=$(echo "${get_response}" | jq -r ".id")

update_environment_variable XILUTION_API_USER_ID "${xilution_user_id}"

echo "All Done! Wrote env variables to .env."
