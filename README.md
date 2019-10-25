<h1 align="center" style="border-bottom: none;">xilution-graphql-backend-example</h1>
<p>
An example demonstrating how to build a GraphQL backend server using Xilution's Beagily and Fox.
<p>
<p align="center">
  <a href="https://github.com/xilution/xilution-graphql-backend-example/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/xilution/xilution-graphql-backend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-graphql-backend-example/network">
    <img alt="Forks" src="https://img.shields.io/github/forks/xilution/xilution-graphql-backend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-graphql-backend-example/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/xilution/xilution-graphql-backend-example.svg">
  </a>
  <a href="https://github.com/xilution/xilution-graphql-backend-example/blob/master/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/xilution/xilution-graphql-backend-example.svg">
  </a>
</p>
<p align="center">
  <a href="https://travis-ci.org/xilution/xilution-graphql-backend-example">
    <img alt="Travis" src="https://img.shields.io/travis/xilution/xilution-graphql-backend-example.svg">
  </a>
</p>
<p align="center">
  <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxilution%2Fxilution-graphql-backend-example">
    <img alt="Tweet" src="https://img.shields.io/twitter/url/https/github.com/xilution/xilution-graphql-backend-example.svg?style=social">
  </a>
</p>

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install NVM: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. Run through the example in [this blog](https://blog.xilution.com/5018604022235529367) to create a Xilution account and create some [Beagily](https://products.xilution.com/basics/beagily) data.

The following are required if you want to follow the "Xilution Fox" instructions below.

1. Create Xilution Account(s)
    1. Open [https://prod.regiser.xilution.com](https://prod.regiser.xilution.com) to create a Prod Xilution account.
    1. Open [https://test.regiser.xilution.com](https://test.regiser.xilution.com) to create a Test Xilution account.
    * Note: Xilution Test and Prod accounts are not synchronized.
1. Install the Xilution CLI: https://docs.xilution.com/cli/
1. Install jq: https://stedolan.github.io/jq/

## General

### To download this repo

1. Run `git clone @xilution/xilution-graphql-backend-example`, to download this repo.

### To download repo dependencies

1. Run `yarn install` to download dependencies.

### To verify the source code

1. Run `yarn verify`.

### To run the server and make live updates

1. Run `yarn start`.
    1. You can make changes to the source code and nodemon will automatically restart the server when the changes are saved.
    1. Open `http://localhost:3000/health` in a browser to verify that the server is running.
    1. Open `http://localhost:3000/graphql` in a browser to see the Apollo Playground.
    1. `Ctrl-c` to stop.

## Docker

### To build the Docker image
This tags your docker image as `xilution-graphql-backend-example`.

1. Run `yarn docker:build`.

### To run the Docker image locally
Uses `docker-compose` to start an NGINX reverse proxy and your docker image.

1. Run `yarn docker:start`.

    1. Open `http://localhost/health` to verify that the server is running.
    1. Because the Docker image was build in production mode, the Apollo Playground is not available.
    1. The GraphQL endpoint can by accessed at `http://localhost/graphql`.

### To stop the Docker image

1. Run `yarn docker:stop`.

### To publish the Docker image to Docker Hub
You'll need a [Docker Hub](https://hub.docker.com/) account to execute the following.

1. Run `yarn docker:publish` to push the image to your Docker Hub account.

## Xilution Fox
Xilution [Fox](https://products.xilution.com/integration/fox) is a managed API hosting solution that uses Docker to instantiate API server instances.
Fox can pull a Docker image from your Docker Hub account.
To grant Fox pull access the Docker image, either make the image public or add `tbrunia` as a [collaborator](https://docs-stage.docker.com/v17.12/docker-hub/repos/#collaborators-and-their-role).

### Activate Fox
Fox must be activated on your Xilution Account before it's available for use.

1. Run `yarn xln:show-activation` to see the status of your Fox activation.

    1. If the Fox activation does not exist or is inactive, run `yarn xln:activate` to activate Xilution Fox.
    2. Conversely, you can run `yarn xln:deactivate` to deactivate Xilution Fox.

### Create a Fox Instance
A Fox Instance contains data that instructs Fox on how to run your Docker image.
You provision a Fox Instance to start your API.
Likewise, you deprovision a Fox Instance to stop your API.

1. Run `yarn xln:show-instances` to see your Fox instances.
    1. If you don't have a `xilution-graphql-backend-example` Fox instance, run `yarn xln:create-instance` to create a new Fox instance.
    Take note of the `id` of the new instance.
    You'll need it in the next step to provision the instance.

### Provision the Fox Instance

1. Run `yarn xln:provision-instance`, to provision the Fox instance.
1. Run `yarn xln:show-instance-status`, to see the status of your Fox instance.
It can take up to 5 minutes to fully provision your Fox instance.
Provisioning is complete when you see the following.
    ```json
    {
       "status": "CREATE_COMPLETE"
    }
   ```

### Access The GraphQL Example Running on Fox

1. Open `https://{your-instance-id}.prod.fox.integration.xilution/health` in a browser to verify that the server is running.
1. Because the Docker image was build in production mode, the Apollo Playground is not available.
1. The GraphQL endpoint can by accessed at `https://{your-instance-id}.prod.fox.integration.xilution/graphql`.

### Restart the Fox Instance
You can make changes to your API and redeploy using the following commands.

1. Run `yarn docker:build`.
1. Run `yarn docker:publish` to push the image to your Docker Hub account.
1. Run `yarn xln:restart-instance`, to restart the instance in the Fox managed API hosting service.

We recommend adding a version endpoint to your API and use it to determine when a new version of your API has been deployed.

### Deprovision the Fox Instance

1. Run `yarn xln:deprovision-instance`, to deprovision the Fox instance.
1. Run `yarn xln:show-instance-status`, to see the status of your Fox instance.
It can take up to 5 minutes to fully deprovision your Fox instance.
Deprovisioning is complete when you see the following.
    ```json
    {
       "status": "NOT_FOUND"
    }
   ```

### Delete the Fox Instance

1. Run `yarn xln:delete-instance`, to delete the Fox instance.

---
Copyright 2019 Teapot, LLC.  
Xilution is a DBA of Teapot, LLC.
