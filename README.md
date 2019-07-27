# xilution-example-fox-beagily-graphql

## Prerequisites

1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install nvm: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. The following environment variables need to be in scope when the server runs.
    XILUTION_CLIENT_ID
    XILUTION_CLIENT_SECRET
    XILUTION_USER_ID

## First Things First

1. Run `yarn` to download dependencies

## To run verify

1. Run `yarn verify`

## To run the server and make live updates

1. Run `yarn start`
    1. You can make changes to the source code and nodemon will automatically restart the server when the changes are saved.

## To build the docker image

1. Run `yarn docker:build`

## To run the docker image

1. Run `yarn docker:start`

## To stop the docker image

1. Run `yarn docker:stop`
