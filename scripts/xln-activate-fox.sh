#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:activate-fox {environment}"
  exit 1
fi

xln-cli api core account_management activate_product \
  --product_id 9ead02f5d8a0420aaa5668e863055168 \
  -p "${environment}" | jq '.effective'
