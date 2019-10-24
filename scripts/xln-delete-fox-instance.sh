#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:delete-fox-instance {environment} {organization_id} {instance_id}"
  exit 1
fi

organization_id=${2}

if [[ -z ${organization_id} ]]; then
  echo "Error! Organization id is required"
  echo "Usage: yarn xln:delete-fox-instance {environment} {organization_id} {instance_id}"
  exit 1
fi

instance_id=${3}

if [[ -z ${instance_id} ]]; then
  echo "Error! Fox instance id is required"
  echo "Usage: yarn xln:delete-fox-instance {environment} {organization_id} {instance_id}"
  exit 1
fi

xln-cli api integration fox delete_instance \
  --organization_id "${organization_id}" \
  --instance_id "${instance_id}" \
  -p "${environment}"
