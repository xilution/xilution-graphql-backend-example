# xilution-example-fox-beagily-graphql

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install nvm: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. Run through the example in [this blog](https://prod.blog.xilution.com/5018604022235529367/) to create some Beagily data.
1. The following environment variables need to be in scope when the server runs.
    XILUTION_CLIENT_ID
    XILUTION_CLIENT_SECRET

## First Things First

1. Run `yarn` to download dependencies

## To run verify

1. Run `yarn verify`

## To run the server and make live updates

1. Run `yarn start`
    1. You can make changes to the source code and nodemon will automatically restart the server when the changes are saved.
    1. Open `http://localhost:3000/health` in a browser to verify that the server is running.
    1. Open `http://localhost:3000/graphql` in a browser to see the Apollo Playground.

## To build the docker image

1. Run `yarn docker:build`

## To run the docker image

1. Run `yarn docker:start`
    1. Open `http://localhost/health` to verify that the server is running.
    1. Because the Docker image was build in production mode, the Apollo Playground is not available.
    1. The GraphQL endpoint can by accessed at `http://localhost/graphql`.

## To stop the docker image

1. Run `yarn docker:stop`
