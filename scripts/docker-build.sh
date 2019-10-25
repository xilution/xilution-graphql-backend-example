#!/usr/bin/env sh

set -e

docker build \
  -t xilution-graphql-backend-example \
  -f docker/Dockerfile .
