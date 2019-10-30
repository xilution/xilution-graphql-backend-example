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

if [[ -z "${1}" ]]; then
  echo "username is required"
  exit 1
fi

if [[ -z "${2}" ]]; then
  echo "code is required"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
username=${1}
code=${2}

curl -s \
  -X POST \
  -H "Content-Type: application/json" \
  -d "{
    \"username\": \"${username}\",
    \"code\": \"${code}\"
  }" \
  "https://${environment}.rhino.basics.api.xilution.com/organizations/${sub_organization_id}/verify-email"
