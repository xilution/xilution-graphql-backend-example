#!/usr/bin/env sh

set -e

if [ $# -lt 6 ]; then
  echo "Usage: yarn xln:create-fox-instance {environment} {organization_id} {owning_user_id} {client_id} {client_secret} {docker_hub_account}"
  exit 1
fi

environment=${1}
organization_id=${2}
owning_user_id=${3}
client_id=${4}
client_secret=${5}
docker_hub_account=${6}

echo "{
  \"@type\": \"instance\",
  \"name\": \"xilution-graphql-backend-example\",
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
  \"image\": \"${docker_hub_account}/xilution-graphql-backend-example\",
  \"owningUserId\": \"${owning_user_id}\",
  \"stack\": \"SMALL_STACK\"
}" >./xilution-graphql-backend-example-temp.json

xln-cli api integration fox create_instance \
  --organization_id "${organization_id}" \
  --input_file ./xilution-graphql-backend-example-temp.json \
  -p "${environment}" | jq '. | {id: .id, name: .name}'

rm -rf ./xilution-graphql-backend-example-temp.json
