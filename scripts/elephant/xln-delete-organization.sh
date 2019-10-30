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

XILUTION_ID_REGEX="^[a-zA-Z0-9]{32}$"
if [[ ! ${1} =~ ${XILUTION_ID_REGEX} ]]; then
  echo "Sub Organization ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${1}

curl -s \
  -X DELETE \
  -H "Authorization: Bearer ${access_token}" \
  "https://${environment}.elephant.basics.api.xilution.com/organizations/${sub_organization_id}"
