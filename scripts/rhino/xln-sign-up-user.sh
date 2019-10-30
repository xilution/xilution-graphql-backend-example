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
  echo "firstName is required"
  exit 1
fi

if [[ -z "${2}" ]]; then
  echo "lastName is required"
  exit 1
fi

if [[ -z "${3}" ]]; then
  echo "email is required"
  exit 1
fi

if [[ -z "${4}" ]]; then
  echo "username is required"
  exit 1
fi

environment=${XILUTION_ENVIRONMENT}
sub_organization_id=${XILUTION_SUB_ORGANIZATION_ID}
firstName=${1}
lastName=${2}
email=${3}
username=${4}
echo -n Password:
read -rs password
echo

curl -s \
  -X POST \
  -H "Content-Type: application/json" \
  -d "{
    \"firstName\": \"${firstName}\",
    \"lastName\": \"${lastName}\",
    \"email\": \"${email}\",
    \"username\": \"${username}\",
    \"password\": \"${password}\"
  }" \
  "https://${environment}.rhino.basics.api.xilution.com/organizations/${sub_organization_id}/sign-up-user"
