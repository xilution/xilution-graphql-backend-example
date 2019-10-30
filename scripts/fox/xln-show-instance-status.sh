#!/usr/bin/env bash

set -e

if [ $# -lt 4 ]; then
  echo "Usage: yarn xln:fox:show-instance-status {environment} {access_token} {sub_organization_id} {instance_id}"
  exit 1
fi

environment=${1}
access_token=${2}
sub_organization_id=${3}
instance_id=${4}

curl -s \
  -X GET \
  -H "Authorization: Bearer ${access_token}" \
  "https://${environment}.fox.integration.api.xilution.com/organizations/${sub_organization_id}/instances/${instance_id}/status"
