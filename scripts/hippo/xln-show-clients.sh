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

if [[ -z "${XILUTION_SUB_ORGANIZATION_ID}" ]]; then
  echo "XILUTION_SUB_ORGANIZATION_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}

curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "https://${environment}.hippo.basics.api.xilution.com/organizations/${sub_organization_id}/clients?page-number=0&page-size=25" |
  jq '.content | if (. | length > 0) then (.[] | {id: .id, name: .name}) else "No clients found." end'
