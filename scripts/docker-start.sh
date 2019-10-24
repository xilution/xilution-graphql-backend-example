#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {user_id} {client_id} {client_secret}"
  exit 1
fi

client_id=${3}

if [[ -z ${client_id} ]]; then
  echo "Error! Client id is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {user_id} {client_id} {client_secret}"
  exit 1
fi

client_secret=${4}

if [[ -z ${client_secret} ]]; then
  echo "Error! Client secret is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {user_id} {client_id} {client_secret}"
  exit 1
fi

XILUTION_ENVIRONMENT=${environment} \
XILUTION_CLIENT_SECRET=${client_secret} \
XILUTION_CLIENT_ID=${client_id} \
docker-compose -f ./docker/docker-compose.yaml up -d
