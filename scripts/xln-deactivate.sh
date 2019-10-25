#!/usr/bin/env sh

set -e

if [ $# -lt 1 ]; then
  echo "Usage: yarn xln:deactivate-fox {environment}"
  exit 1
fi

environment=${1}

xln-cli api core account_management deactivate_product \
  --product_id 9ead02f5d8a0420aaa5668e863055168 \
  -p "${environment}" | jq '.effective'
