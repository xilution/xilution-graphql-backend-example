#!/usr/bin/env bash

set -e

docker build \
  -t xilution-graphql-backend-example \
  -f docker/Dockerfile .
