#!/usr/bin/env bash

set -e

. ./scripts/common-functions.sh

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
client_id="dc638b67f9d24798bb97f183ee572bb3"
echo -n Username:
read -r username
echo -n Password:
read -rs password
echo

response=$(curl -s \
  -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password&client_id=${client_id}&username=${username}&password=${password}&scope=read write" \
  "https://${environment}.authentication.core.api.xilution.com/oauth/token")

echo "${response}" |
  jq "{ xilution_account_access_token: .access_token, xilution_account_organization_id: .user.organizationId, xilution_account_user_id: .user.id }"

xilution_account_access_token=$(echo "${response}" | jq -r ".access_token")
xilution_account_organization_id=$(echo "${response}" | jq -r ".user.organizationId")
xilution_account_user_id=$(echo "${response}" | jq -r ".user.id")

update_environment_variable XILUTION_ACCOUNT_ACCESS_TOKEN "${xilution_account_access_token}"
update_environment_variable XILUTION_ACCOUNT_ORGANIZATION_ID "${xilution_account_organization_id}"
update_environment_variable XILUTION_ACCOUNT_USER_ID "${xilution_account_user_id}"

echo "All Done! Wrote env variables to .env."
