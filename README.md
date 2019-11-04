<h1>xilution-graphql-backend-example</h1>
<p>
An example demonstrating how to build a GraphQL backend using...
<p>
<ul>
    <li>
        Xilution's IAM Suite (<a href="https://products.xilution.com/api/catalog/basics/elephant">Elephant</a>, <a href="https://products.xilution.com/api/catalog/basics/hippo">Hippo</a>, <a href="https://products.xilution.com/api/catalog/basics/rhino">Rhino</a>, <a href="https://products.xilution.com/api/catalog/basics/zebra">Zebra</a>)
    </li>
    <li>
        Xilution's Data Storage Service (<a href="https://products.xilution.com/api/catalog/basics/beagily">Beagily</a>)
    </li>
    <li>
        Xilution's API Hosting Service (<a href="https://products.xilution.com/api/catalog/integration/fox">Fox</a>)
    </li>
</ul>
<p>
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
<p>
  <a href="https://travis-ci.org/xilution/xilution-graphql-backend-example">
    <img alt="Travis" src="https://img.shields.io/travis/xilution/xilution-graphql-backend-example.svg">
  </a>
</p>
<p>
  <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fxilution%2Fxilution-graphql-backend-example">
    <img alt="Tweet" src="https://img.shields.io/twitter/url/https/github.com/xilution/xilution-graphql-backend-example.svg?style=social">
  </a>
</p>

## Time Requirement

I will take about thirty (30) minutes to run through this example.

## Use Case

**As:** a frontend app builder who creates apps for multiple clients.

**I want:** a [GraphQL](https://graphql.org/) enabled API that restricts access to only known users.

**So that:** I can build a pet data management app for one of my clients.

## Xilution Product Hierarchy

Here's a quick overview of the Xilution products highlighted in this example.
For a complete directory of Xilution products, see https://prod.products.xilution.com/.

```text
                 +------------------+
                 | Xilution Account |
                 +--------+---------+
                          |
                          v
                   +------+-------+
                   | Organization +--------------+
                   +------+-------+              |
                          |                      |
                          v                      |
               +----------+----------+           |
               |    [ Elephant ]     |           |
               | Sub-Organization(s) |           |
               +----------+----------+           |
                          |                      |
                          v                      |
          +--------------------------------+     |
          |               |                |     |
          v               v                v     v
    +-----+-----+   +-----+-----+      +---+-----+---+
    | [ Hippo ] |   | [ Rhino ] |      |   [ Fox ]   |
    | Client(s) |   |  User(s)  |      | Instance(s) |
    +-----------+   +-----------+      +-------------+
```

* [Elephant](https://products.xilution.com/api/catalog/basics/elephant)
* [Hippo](https://products.xilution.com/api/catalog/basics/hippo)
* [Rhino](https://products.xilution.com/api/catalog/basics/rhino)
* [Fox](https://products.xilution.com/api/catalog/integration/fox)

When you create a Xilution Account, an Organization record is created for you.
This is referred to as your "Account Organization" in the instructions below.
As a frontend app builder who supports multiple clients, you can create multiple Sub-Organizations via Xilution Elephant.
One for each client you support.
This allows you to separate client resource management and billing from your Account Organization and other Sub-Organizations.

Xilution Hippo is part of Xilution's IAM suite and manages Sub-Organization clients.
A client is a reference to a web or mobile application.
In this example, you'll create one Sub-Organization client.

Xilution Rhino is part of Xilution's IAM suite and manages Sub-Organization users.
In this example, you'll create one Sub-Organization user.

Xilution Fox is a managed API hosting solution that uses [Docker](https://www.docker.com/) to instantiate API server instances.
You can associate Fox instances with your Account Organization and/or Sub-Organizations.
In this example, you'll associated a Fox instance with a Sub-Organization.

## Implemented Solution

When you complete this example, you will create a GraphQL enabled API that supports the use case mentioned above.

```text
                                  +-----------+
                            +---->+ [ Zebra ] |
                            |     |   Auth    |
                            |     +-----------+
            +---------+     |
       o----+ [ Fox ] +---->+
    GraphQL |   API   |     |
            +---------+     |
                            |    +--------------+
                            +--->+ [ Beagily ]  |
                                 | Data Storage |
                                 +--------------+
```

* [Zebra](https://products.xilution.com/api/catalog/basics/zebra)
* [Beagily](https://products.xilution.com/api/catalog/basics/beagily)
* [Fox](https://products.xilution.com/api/catalog/integration/fox)

The API authorizes calls to it's `/graphql` endpoint by making `/oauth/authenticate` calls to Xilution Zebra with the Bearer token included in the Authorization header of each request.
Xilution Zebra is [OAuth 2.0](https://oauth.net/2/) compliant and is part of Xilution's IAM (identity and access management) suite and is used to authenticate and authorize Rhino users and Hippo clients.

The API interfaces with Xilution Beagily to store and retrieve Pet data.
Xilution Beagily is a simple JSON data storage API that features integrated search and access control features.
The API makes calls to Beagily with a Bearer token included in the Authorization header of each request.
This token is separate from than the token included in requests to the API's `/graphql` endpoint and is acquired by the API from Zebra using the credentials of a client referred to as API Client in the instructions below.
Each Beagily record has an owning user and an access policy which is checked against a context generated by the access token to control access to records.

## Features

* Xilution's IAM Suite ([Elephant](https://products.xilution.com/api/catalog/basics/elephant), [Hippo](https://products.xilution.com/api/catalog/basics/hippo), [Rhino](https://products.xilution.com/api/catalog/basics/rhino) and [Zebra](https://products.xilution.com/api/catalog/basics/zebra)) for identity and access management.
* Xilution [Fox](https://products.xilution.com/api/catalog/integration/fox) for API hosting.
* Xilution [Beagily](https://products.xilution.com/api/catalog/basics/beagily) for data storage.
* [GraphQL](https://graphql.org/) enabled API running on a [Hapi](https://github.com/hapijs/hapi) (NodeJS) server using the [Apollo Server](https://github.com/apollographql/apollo-server/tree/master/packages/apollo-server-hapi).

## Prerequisites

1. Create a Xilution Account
    1. Open [https://prod.register.xilution.com](https://prod.register.xilution.com) to create a Xilution **Prod** account.
        * :mega: A valid credit card :credit_card: must be associated with your Xilution Account to use Xilution Products in Prod.
          Use the [Prod environment Xilution Admin Portal](https://prod.portal.xilution.com) to add a Credit Card to your Xilution Account.
    1. Open [https://test.register.xilution.com](https://test.register.xilution.com) to create a Xilution **Test** account.
        * Xilution Test and Prod accounts are not synchronized.
        * Some Xilution products have usage and time to live restrictions in our Test environment.
          See [product documentation](https://test.products.xilution.com/) for complete restriction details.
1. Install Docker Desktop: https://www.docker.com/products/docker-desktop
1. Install NVM: https://github.com/nvm-sh/nvm
1. Install Yarn: https://yarnpkg.com
1. Install jq: https://stedolan.github.io/jq/
1. Install cURL: https://curl.haxx.se/

## General

### To Install Dependencies

1. Run `yarn install` to download dependencies.

### To Verify The Source Code

1. Run `yarn verify`.

## Set Up

The following instructions are enabled via a large suite of scripts found in the [scripts](./scripts) folder of this repo.
You can see the changes made to your account via the scripts through our product portals.
You'll authenticate to the portals with your Xilution Account username and password.

| Portal   | Prod                                                      | Test                                                      |
|----------|-----------------------------------------------------------|-----------------------------------------------------------|
| Account  | https://prod.portal.xilution.com/                         | https://test.portal.xilution.com/                         |
| Elephant | https://prod.portal.elephant.basics.xilution.com/         | https://test.portal.elephant.basics.xilution.com/         |
| Rhino    | https://prod.portal.rhino.basics.xilution.com/            | https://test.portal.rhino.basics.xilution.com/            |
| Hippo    | https://prod.portal.hippo.basics.xilution.com/            | https://test.portal.hippo.basics.xilution.com/            |
| Fox      | https://prod.portal.fox.integration.xilution.com/         | https://test.portal.fox.integration.xilution.com/         |

### Environment Variables

1. Run `touch .env` to create a new environment variables file.
1. Run `echo "XILUTION_ENVIRONMENT={environment}" >>.env` to add your environment preference to the environment variables file (.env).
    * {environment} is a Xilution environment. One of 'test' or 'prod'.

### Account Organization Authentication

1. Run `yarn xln:authentication:token-from-user-credentials`.
    * You will be prompted for your Xilution Account username and password.
    * The access token saved to the environment variables file will expire in one hour.

### Account Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:elephant:activate-for-account-organization`.
1. Run `yarn xln:hippo:activate-for-account-organization`.
1. Run `yarn xln:rhino:activate-for-account-organization`.

* Run `yarn xln:{product-name}:show-activation-for-account-organization` to see the status of an account organization's product activation.
    * {product-name} is one of `elephant`, `hippo` or `rhino`.
* Run `yarn xln:{product-name}:deactivate-for-account-organization` to deactivate a product for an account organization.

### Create a Xilution Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:elephant:create-sub-organization`.

* :mega: A valid credit card :credit_card: must be associated with your Xilution Sub-Organization to use Xilution Products in Prod.
  Use the [Prod environment Xilution Elephant Portal](https://prod.portal.elephant.basics.xilution.com/) to add a Credit Card to your Xilution Sub-Organization.
* To see your Sub-Organizations, run `yarn xln:elephant:show-organizations`.
* To delete a Sub-Organization, run `yarn xln:elephant:delete-organization {sub-organization-id}`
    * {sub-organization-id} is a Sub-Organization id.

### Sub-Organization Product Activation

Note: Requires Account Organization Authentication

1. Run `yarn xln:zebra:activate-for-sub-organization`.
1. Run `yarn xln:beagily:activate-for-sub-organization`.
1. Run `yarn xln:fox:activate-for-sub-organization`.

* Run `yarn xln:{product-name}:show-activation-for-sub-organization` to see the status of a Sub-Organization's product activation.
    * {product-name} is one of `zebra`, `beagily` or `fox`.
* Run `yarn xln:{product-name}:deactivate-for-sub-organization` to deactivate a product for a Sub-Organization.

### Add an API User to the Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:rhino:sign-up-api-user {email} {username}`.
    * {email} is the new user's email address. Enter an email address that you have access to.
    * {username} is the new user's username.
    * A verification code will be emailed to the email address you entered when signing up the new user.
1. Run `yarn xln:rhino:verify-user-email {username} {code}` to verify the new user's email.
    * {username} is the new user's username.
    * {code} is the verification code the you received in your email inbox.

* To see the Sub-Organization's users run, `yarn xln:rhino:show-users`.
* To delete a Sub-Organization's user run, `yarn xln:rhino:delete-user {user-id}`.

### Add an API Client to the Sub-Organization

Note: Requires Account Organization Authentication

1. Run `yarn xln:hippo:create-api-client`.

* To see the Sub-Organization's clients run, `yarn xln:hippo:show-clients`.
* To delete a Sub-Organization's client run, `yarn xln:hippo:delete-client {client-id}`.

### Sub-Organization Authentication

1. Run `yarn xln:zebra:token-from-api-client-credentials`.

### Prime Beagily with Some Data

Note: Requires Sub-Organization Authentication

1. Run `yarn xln:beagily:create-pet-type`.
1. Run `yarn xln:beagily:create-pet {name}` a few times, passing some different pet names. 
   * {name} is a pet's name.

## Running Locally

1. Run `export $(grep -v '^#' .env | xargs)`.
    * Requires the Set Up step to be complete.
1. Run `yarn start`.
    * You can make changes to the source code and nodemon will automatically restart the server when the changes are saved.
    * Open http://localhost:3123/health in a browser to verify that the server is running.
    * Open http://localhost:3123/graphql in a browser to see the Apollo Playground.
        * Requires Authentication. See Example GraphQL Queries and Mutations / Authentication below.
    * `Ctrl-c` to stop.

## Example GraphQL Queries and Mutations

You can use variants of the following queries to test your API in the Apollo Playground.

### Authentication

For each of the following queries and mutations, you'll need to include the following header.

```json
{
  "Authorization": "Bearer {xilution-api-access-token}"
}
```

1. Run `yarn xln:zebra:token-from-api-client-credentials` to regenerate an API access token.

1. Run `cat .env | grep XILUTION_API_ACCESS_TOKEN` to see the access token you just generated. You'll need this when you make requests to the API's `graphql` endpoint.
    * Replace `{xilution-api-access-token}` in the JSON snippet above.

### List Pets

**Query**
```text
query Pets($sort: String, $query: String, $pageNumber: Int, $pageSize: Int) {
  pets(sort: $sort, query: $query, pageNumber: $pageNumber, pageSize: $pageSize) {
    data: content {
      id
      name
      createdAt
      owningUserId
    }
    total: totalElements
  }
}
```

**Variables**
```text
{
	"pageNumber": {page-number},
	"pageSize": {page-size}
}
```

### Get Pet

**Query**
```text
query Pets($id: String!) {
  pet(id: $id) {
    id
    name
    createdAt
    owningUserId
  }
}
```

**Variables**
```text
{
	"id": "{pet-id}"
}
```

### Delete Pet

**Mutation**
```text
mutation Pets($id: String!) {
  deletePet(id: $id) {
    id
  }
}
```

**Variables**
```text
{
	"id": "{pet-id}"
}
```

### Create Pet

**Mutation**
```text
mutation Pets($newPet: NewPet!) {
  createPet(pet: $newPet) {
      id
      name
      createdAt
      owningUserId
  }
}
```

**Variables**
```text
{
	"newPet": {
		"name": "{name}",
		"owningUserId": "{owning-user-id}"
	}
}
```

### Update Pet

**Mutation**
```text
mutation Pets($id: String! $updatedPet: UpdatedPet!) {
  updatePet(id: $id pet: $updatedPet) {
      id
      name
      createdAt
      owningUserId
  }
}
```

**Variables**
```text
{
	"id": "{pet-id}",
	"updatedPet": {
		"name": "{name}"
	}
}
```

## Host on Xilution Fox

Fox can pull a Docker image from your Docker Hub account.
To grant Fox pull access the Docker image, either make the image public or add `tbrunia` as a [collaborator](https://docs-stage.docker.com/v17.12/docker-hub/repos/#collaborators-and-their-role).

### Build the Docker image

This tags your docker image as `xilution-graphql-backend-example`.

1. Run `yarn docker:build`.

### To run the Docker image locally

1. Run `yarn docker:start`.
    * Open `http://localhost:3123/health` to verify that the server is running.
    * Because the Docker image was build in production mode, the Apollo Playground is not available.
    * The GraphQL endpoint can by accessed at `http://localhost:3123/graphql`.

### To stop the Docker image

1. Run `yarn docker:stop`.

### Publish the Docker image to Docker Hub

You'll need a [Docker Hub](https://hub.docker.com/) account to execute the following.

1. Run `yarn docker:publish {docker_hub_account}` to push the image to your Docker Hub account.

### Create a Fox Instance

Note: Requires Account Organization Authentication

A Fox Instance contains data that instructs Fox on how to run your Docker image.
You provision a Fox Instance to start your API.
Likewise, you deprovision a Fox Instance to stop your API.

1. Run `yarn xln:fox:create-instance`.

* To see your instances, run `yarn xln:fox:show-instances`.
* To delete a instance, run `yarn xln:fox:delete-instance {fox-instance-id}`.

### Provision the Fox Instance

Note: Requires Account Organization Authentication

1. Run `yarn xln:provision-fox-instance`, to provision the Fox instance.
1. Run `yarn xln:show-fox-instance-status`, to see the status of your Fox instance.
    * It can take up to 5 minutes to fully provision your Fox instance.
    * Provisioning is complete when you see the following.
        ```json
        {
           "status": "CREATE_COMPLETE"
        }
       ```
    * Now you can access the GraphQL Example running on Fox.

### Access The GraphQL Example Running on Fox

1. Run `cat .env | grep XILUTION_INSTANCE_ID` to see your Fox Instance ID.
1. Open `https://{fox-instance-id}.prod.fox.integration.xilution/health` in a browser to verify that the server is running.

The Apollo Playground is not available when running in Fox because the Docker image was build in production mode, 
1. The GraphQL endpoint can by accessed at `https://{your-fox-instance-id}.prod.fox.integration.xilution/graphql`.

### Restart the Fox Instance

Note: Requires Account Organization Authentication

You can make changes to your API, build and redeploy using the following commands.

1. Run `yarn docker:build`.
1. Run `yarn docker:publish` to push the image to your Docker Hub account.
1. Run `yarn xln:fox:restart-instance`, to restart the instance in the Fox managed API hosting service.

We recommend adding a version endpoint to your API and use it to determine when a new version of your API has been deployed.

### Deprovision the Fox Instance

Note: Requires Account Organization Authentication

1. Run `yarn xln:fox:deprovision-instance`, to deprovision the Fox instance.
1. Run `yarn xln:fox:show-instance-status`, to see the status of your Fox instance.
    * It can take up to 5 minutes to fully deprovision your Fox instance.
    * Deprovisioning is complete when you see the following.
        ```json
        {
           "status": "NOT_FOUND"
        }
       ```

### Delete the Fox Instance

Note: Requires Account Organization Authentication

1. Run `yarn xln:fox:delete-instance {fox-instance-id}`, to delete the Fox instance.

---
Copyright 2019 Teapot, LLC.  
Xilution is a DBA of Teapot, LLC.
