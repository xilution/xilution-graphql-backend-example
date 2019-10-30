#!/usr/bin/env bash

set -e

if [ $# -lt 1 ]; then
  echo "Usage: yarn docker:publish {docker_hub_account}"
  exit 1
fi

docker_hub_account=${1}

echo "Please enter your Docker Hub account password to publish xilution-graphql-backend-example."
docker login -u "${docker_hub_account}"
docker tag xilution-graphql-backend-example "${docker_hub_account}"/xilution-graphql-backend-example
docker push "${docker_hub_account}"/xilution-graphql-backend-example
