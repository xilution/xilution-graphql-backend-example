#!/usr/bin/env bash

. ./scripts/common-functions.sh

set -e

if [ $# -lt 3 ]; then
  echo "Usage: yarn xln:zebra:show-activation {environment} {access_token} {sub_organization_id}"
  exit 1
fi

environment=${1}
access_token=${2}
sub_organization_id=${3}
product_id="97d2a61756ca4f13aee8a5cb4268cdc4"

elephant_show_activation \
  "${environment}" \
  "${access_token}" \
  "${sub_organization_id}" \
  "${product_id}"
