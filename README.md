# xilution-graphql-example

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install NVM: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. Run through the example in [this blog](https://blog.xilution.com/5018604022235529367) to create a Xilution account and create some [Beagily](https://products.xilution.com/basics/beagily) data.
1. The following environment variables need to be in scope when the server runs.
    * XILUTION_CLIENT_ID
    * XILUTION_CLIENT_SECRET
1. Install the [Xilution CLI](https://docs.xilution.com/cli/).
    1. Required if you want to follow the "To run the Docker image on Fox" instructions below.

## To download this repo

1. Run `git clone @xilution/xilution-graphql-example`, to download this repo.

## To download repo dependencies

1. Run `yarn` to download dependencies.

## To verify the source code

1. Run `yarn verify`.

## To run the server and make live updates

1. Run `yarn start`
    1. You can make changes to the source code and nodemon will automatically restart the server when the changes are saved.
    1. Open `http://localhost:3000/health` in a browser to verify that the server is running.
    1. Open `http://localhost:3000/graphql` in a browser to see the Apollo Playground.

## To build the Docker image
This tags your docker image as `xilution-graphql-example`.

1. Run `yarn docker:build`.

## To run the Docker image locally
Uses `docker-compose` to start an NGINX reverse proxy and your docker image.

1. Run `yarn docker:start`.

    1. Open `http://localhost/health` to verify that the server is running.
    1. Because the Docker image was build in production mode, the Apollo Playground is not available.
    1. The GraphQL endpoint can by accessed at `http://localhost/graphql`.

## To stop the Docker image

1. Run `yarn docker:stop`.

## To publish the Docker image to Docker Hub
You'll need a Docker Hub account to execute the following.

1. Run `docker login`, to login to Docker Hub.

## To publish the Docker image to your Docker Hub account
You'll need a Docker Hub account to execute the following.

1. Run `docker tag xilution-graphql-example {your-docker-hub-account}/xilution-graphql-example` to tag the image so it can be pushed to your Docker Hub account.
1. Run `docker push {your-docker-hub-account}/xilution-graphql-example` to push the image to your Docker Hub account.

## To run the Docker image on Xilution Fox
Xilution [Fox](https://products.xilution.com/integration/fox) is a managed API hosting solution that uses Docker to instantiate API server instances.
Fox pulls the Docker image from your Docker Hub account.
To grant Fox pull access the Docker image, either make the image public or add `tbrunia` as a [collaborator](https://docs-stage.docker.com/v17.12/docker-hub/repos/#collaborators-and-their-role).

The Xilution CLI commands below use the default profile.
See [the Xilution CLI config documentation](https://github.com/xilution/xilution-cli/blob/master/docs/config.md) for more information about how to manage and use profiles.

### Activate Fox
Fox must be activated on your Xilution Account before it's available for use.
Note: `9ead02f5d8a0420aaa5668e863055168` is the Fox product ID.

1. Run `xln-cli api core account_management list_product_activations --page_number=0 --page_size=10` to see your activations.

    1. If the Fox activation does not exist or it is inactive (see the `effective` property on the `activation` record), run `xln-cli api core account_management activate_product --product_id 9ead02f5d8a0420aaa5668e863055168` to activate Xilution Fox.

### Create a Fox Instance
A Fox Instance is configuration that tells Fox how to run your Docker image.
You provision a Fox Instance to start your API.
Likewise, you deprovision a Fox Instance to stop your API.

1. Run `xln-cli api integration fox list_instances --organization_id {your-xilution-organization-id} --page_number=0 --page_size=10` to see your Fox instances.
    1. If you don't have an instance, create a file on your local filesystem with the following JSON content.
    Be sure to replace the content between curly brackets with your Xilution account information.
        ```json
        {
          "@type": "instance",
          "name": "xilution-graphql-example",
          "organizationId": "{your-xilution-organization-id}",
          "containerPort": "3000",
          "environment": [
            {
              "name": "XILUTION_CLIENT_ID",
              "value": "{your-xilution-client-id}"
            },
            {
              "name": "XILUTION_CLIENT_SECRET",
              "value": "{your-xilution-client-secret}"
            }
          ],
          "image": "{your-docker-hub-account}/xilution-graphql-example",
          "owningUserId": "{your-xilution-user-id}",
          "stack": "SMALL_STACK"
        }
        ```
    1. Then, run `xln-cli api integration fox create_instance --organization_id {your-xilution-organization-id} --input_file {path_to_json_file}` to create a new fox instance.
    Take note of the `id` of the new instance.
    You'll need it in the next step to provision the instance.

### Provision the Fox Instance

1. Run `xln-cli api integration fox provision_instance --organization_id {your-xilution-organization-id} --instance_id {your-fox-instance-id}`, to provision the instance in the Fox managed API hosting service.
1. Run `xln-cli api integration fox get_instance_status --organization_id {your-xilution-organization-id} --instance_id {your-fox-instance-id}`, to see the status of your instance.
It can take up to 5 minutes to fully provision your instance.
Provisioning is complete when you see the following.
    ```json
    {
       "status": "CREATE_COMPLETE"
    }
   ```

### Access the Fox Instance

1. Open `https://{your-fox-instance-id}.test.fox.integration.xilution/health` in a browser to verify that the server is running.
1. Because the Docker image was build in production mode, the Apollo Playground is not available.
1. The GraphQL endpoint can by accessed at `https://{your-fox-instance-id}.test.fox.integration.xilution/graphql`.

### Deprovision the Fox Instance

1. Run `xln-cli api integration fox deprovision_instance --organization_id {your-xilution-organization-id} --instance_id {your-fox-instance-id}`, to deprovision the instance in the Fox managed API hosting service.
1. Run `xln-cli api integration fox get_instance_status --organization_id {your-xilution-organization-id} --instance_id {your-fox-instance-id}`, to see the status of your instance.
It can take up to 10 minutes to fully deprovision your instance.
Deprovisioning is complete when you see the following.
    ```json
    {
       "status": "NOT_FOUND"
    }
   ```

### Delete the Fox Instance

1. Run `xln-cli api integration fox delete_instance --organization_id {your-xilution-organization-id} --instance_id {your-fox-instance-id}`, to delete the instance from Fox.
