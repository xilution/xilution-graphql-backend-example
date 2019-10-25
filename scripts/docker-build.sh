#!/usr/bin/env sh

set -e

docker build \
  -t xilution-graphql-example \
  -f docker/Dockerfile .
