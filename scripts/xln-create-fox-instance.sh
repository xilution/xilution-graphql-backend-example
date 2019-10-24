#!/usr/bin/env bash

set -e

environment=${1}

if [[ -z ${environment} ]]; then
  echo "Error! Xilution environment is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

organization_id=${2}

if [[ -z ${organization_id} ]]; then
  echo "Error! Organization id is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

owning_user_id=${3}

if [[ -z ${owning_user_id} ]]; then
  echo "Error! Owning user id is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

client_id=${4}

if [[ -z ${client_id} ]]; then
  echo "Error! Client id is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

client_secret=${5}

if [[ -z ${client_secret} ]]; then
  echo "Error! Client secret is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

docker_hub_account=${6}

if [[ -z ${docker_hub_account} ]]; then
  echo "Error! Docker Hub Account is required"
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

echo "{
  \"@type\": \"instance\",
  \"name\": \"xilution-graphql-example\",
  \"organizationId\": \"${organization_id}\",
  \"containerPort\": \"3000\",
  \"environment\": [
    {
      \"name\": \"XILUTION_CLIENT_ID\",
      \"value\": \"${client_id}\"
    },
    {
      \"name\": \"XILUTION_CLIENT_SECRET\",
      \"value\": \"${client_secret}\"
    }
  ],
  \"image\": \"${docker_hub_account}/xilution-graphql-example\",
  \"owningUserId\": \"${owning_user_id}\",
  \"stack\": \"SMALL_STACK\"
}" > ./xilution-graphql-example-temp.json

xln-cli api integration fox create_instance \
  --organization_id "${organization_id}" \
  --input_file ./xilution-graphql-example-temp.json \
  -p "${environment}" | jq '. | {id: .id, name: .name}'

rm -rf ./xilution-graphql-example-temp.json
