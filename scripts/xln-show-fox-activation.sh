#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:show-fox-activation {environment}"
  exit 1
fi

xln-cli api core account_management list_product_activations \
  --page_number=0 \
  --page_size=25 \
  -p "${environment}" | jq '.content | map(select(.id == "9ead02f5d8a0420aaa5668e863055168")) | if (. | length > 0) then .[] .effective else "Fox is not active." end'
