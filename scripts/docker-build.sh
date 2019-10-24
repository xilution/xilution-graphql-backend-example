#!/usr/bin/env bash

set -e

docker build -t xilution-graphql-example -f docker/Dockerfile .
