#!/usr/bin/env sh

set -e

if [ $# -lt 3 ]; then
  echo "Usage: yarn docker:start {environment} {client_id} {client_secret}"
  exit 1
fi

environment=${1}
client_id=${2}
client_secret=${3}

XILUTION_ENVIRONMENT=${environment} XILUTION_CLIENT_SECRET=${client_secret} XILUTION_CLIENT_ID=${client_id} \
  docker-compose -f ./docker/docker-compose.yaml up -d
