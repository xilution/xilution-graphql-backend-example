#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:show-fox-instances {environment} {organization_id}"
  exit 1
fi

organization_id=${2}

if [[ -z ${organization_id} ]]; then
  echo "Error! Organization id is required"
  echo "Usage: yarn xln:show-fox-instances {environment} {organization_id}"
  exit 1
fi

xln-cli api integration fox list_instances \
  --organization_id "${organization_id}" \
  --page_number=0 \
  --page_size=25 \
  -p "${environment}" | jq '.content | if (. | length > 0) then (.[] | {id: .id, name: .name}) else "No instances found." end'
