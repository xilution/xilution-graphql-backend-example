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

if [[ -z "${XILUTION_FOX_INSTANCE_ID}" ]]; then
  echo "XILUTION_FOX_INSTANCE_ID not found in .env"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
fox_instance_id=${XILUTION_FOX_INSTANCE_ID}

response=$(curl -s \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{}" \
  "https://${environment}.fox.integration.api.xilution.com/organizations/${sub_organization_id}/instances/${fox_instance_id}/provision")

echo "${response}"
