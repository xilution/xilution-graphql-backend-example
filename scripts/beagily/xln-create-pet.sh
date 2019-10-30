#!/usr/bin/env bash

set -e

source .env

if [[ -z "${XILUTION_ENVIRONMENT}" ]]; then
  echo "XILUTION_ENVIRONMENT not found in .env"
  exit 1
fi

if [[ -z "${XILUTION_API_ACCESS_TOKEN}" ]]; then
  echo "XILUTION_API_ACCESS_TOKEN not found in .env"
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

if [[ -z "${1}" ]]; then
  echo "name is required"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_API_ACCESS_TOKEN}
user_id=${XILUTION_ACCOUNT_USER_ID}
name=${1}

curl -s \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"@type\": \"pet\",
    \"name\": \"${name}\",
    \"owningUserId\": \"${user_id}\"
  }" \
  "https://${environment}.beagily.basics.api.xilution.com/things?type=pet"
