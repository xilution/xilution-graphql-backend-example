#!/usr/bin/env bash

set -e

docker_hub_account=${1}

if [[ -z ${docker_hub_account} ]]; then
  echo "Error! Docker Hub Account is required"
  echo "Usage: yarn docker:publish {docker_hub_account}"
  exit 1
fi

echo "Please enter your Docker Hub account password to publish xilution-graphql-example."
docker login -u "${docker_hub_account}"
docker tag xilution-graphql-example "${docker_hub_account}"/xilution-graphql-example
docker push "${docker_hub_account}"/xilution-graphql-example
