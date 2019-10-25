#!/usr/bin/env sh

set -e

if [ $# -lt 2 ]; then
  echo "Usage: yarn xln:show-fox-instances {environment} {organization_id}"
  exit 1
fi

environment=${1}
organization_id=${2}

xln-cli api integration fox list_instances \
  --organization_id "${organization_id}" \
  --page_number=0 \
  --page_size=25 \
  -p "${environment}" | jq '.content | if (. | length > 0) then (.[] | {id: .id, name: .name}) else "No instances found." end'
