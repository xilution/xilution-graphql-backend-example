#!/usr/bin/env bash

. ./scripts/common-functions.sh

set -e

if [ $# -lt 4 ]; then
  echo "Usage: yarn xln:zebra:deactivate {environment} {access_token} {sub_organization_id} {owning_user_id}"
  exit 1
fi

environment=${1}
access_token=${2}
sub_organization_id=${3}
owning_user_id=${4}
effective_to=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")
product_id="97d2a61756ca4f13aee8a5cb4268cdc4"

elephant_deactivate \
  "${environment}" \
  "${access_token}" \
  "${sub_organization_id}" \
  "${owning_user_id}" \
  "${effective_to}" \
  "${product_id}"
