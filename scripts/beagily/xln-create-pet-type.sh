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

environment=${XILUTION_ENVIRONMENT}
access_token=${XILUTION_API_ACCESS_TOKEN}

curl -s \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${access_token}" \
  -d "{
    \"\$schema\": \"http://json-schema.org/schema#\",
    \"title\": \"Pet Schema\",
    \"type\": \"object\",
    \"properties\": {
      \"@type\": {
        \"enum\": [
          \"pet\"
        ],
        \"type\": \"string\"
      },
      \"owningUserId\": {
        \"type\": \"string\"
      },
      \"name\": {
        \"type\": \"string\"
      }
    },
    \"required\": [
      \"@type\",
      \"owningUserId\",
      \"name\"
    ]
  }" \
  "https://${environment}.beagily.basics.api.xilution.com/types/pet"
