#!/usr/bin/env bash

account_management_activate() {
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
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  product_id=${1}

  curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${access_token}" \
    -d "{}" \
    "https://${environment}.account-management.core.api.xilution.com/activate/${product_id}" |
    jq '.effective'
}

account_management_deactivate() {
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
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  product_id=${1}

  curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${access_token}" \
    -d "{}" \
    "https://${environment}.account-management.core.api.xilution.com/deactivate/${product_id}" |
    jq '.effective'
}

account_management_show_activation() {
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
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  product_id=${1}

  curl -s \
    -X GET \
    -H "Authorization: Bearer ${access_token}" \
    "https://${environment}.account-management.core.api.xilution.com/activations?page-number=0&page-size=10" |
    jq ".content | map(select(.productId == \"${product_id}\")) | if (. | length > 0) then .[] .effective else \"Not active.\" end"
}

elephant_activate() {
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

  XILUTION_ID_REGEX="^[a-zA-Z0-9]{32}$"
  if [[ ! ${1} =~ ${XILUTION_ID_REGEX} ]]; then
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
  product_id=${1}

  curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${access_token}" \
    -d "{}" \
    "https://${environment}.elephant.basics.api.xilution.com/organizations/${sub_organization_id}/products/${product_id}/activate" |
    jq '.effective'
}

elephant_deactivate() {
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

  XILUTION_ID_REGEX="^[a-zA-Z0-9]{32}$"
  if [[ ! ${1} =~ ${XILUTION_ID_REGEX} ]]; then
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
  product_id=${1}

  curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${access_token}" \
    -d "{}" \
    "https://${environment}.elephant.basics.api.xilution.com/organizations/${sub_organization_id}/products/${product_id}/deactivate" |
    jq '.effective'
}

elephant_show_activation() {
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

  XILUTION_ID_REGEX="^[a-zA-Z0-9]{32}$"
  if [[ ! ${1} =~ ${XILUTION_ID_REGEX} ]]; then
    echo "Product ID (${1}) should match the pattern: ${XILUTION_ID_REGEX}"
    exit 1
  fi

  environment=${XILUTION_ENVIRONMENT}
  access_token=${XILUTION_ACCOUNT_ACCESS_TOKEN}
  sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
  product_id=${1}

  curl -s \
    -X GET \
    -H "Authorization: Bearer ${access_token}" \
    "https://${environment}.elephant.basics.api.xilution.com/organizations/${sub_organization_id}/activations?page-number=0&page-size=10" |
    jq ".content | map(select(.productId == \"${product_id}\")) | if (. | length > 0) then .[] .effective else \"Not active.\" end"
}

update_environment_variable() {
  found=0

  while IFS="" read -r line || [ -n "$line" ]; do
    if [[ $line =~ ^${1}=.*$ ]]; then
      found=1
      echo "${1}=${2}" >>.env.temp
    else
      echo "$line" >>.env.temp
    fi
  done <.env

  if [[ $found == 0 ]]; then
    echo "${1}=${2}" >>.env.temp
  fi

  mv .env.temp .env
}
