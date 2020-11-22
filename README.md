# Github Issue Action

This action allows WSO2 API Manager Cloud users to automate CICD

## How this works

In this version of APIMCloud CICD Action, you can automate creating an API project with given API definition and publish it in the development tenant. Then it can be tested with a postman collections.
If all checks passed, API project can be exported from the development tenant to the production tenant.

## Inputs

### `usernameDevTenant`

**Required** Dev tenant username as username@organization.com@DevtenantName

### `passwordDevTenant`

**Required** Dev tenant user's password should be stored in github repo secrets and use it here like ${{secrets.PASSWORD}}

### `usernameDevTenant`

**Required** Prod tenant username as username@organization.com@ProdtenantName

### `passwordProdTenant`

**Required** Prod tenant user's password should be stored in github repo secrets and use it here like ${{secrets.PASSWORD}}

### `APIProjectName`

**Required** Give a name for your API Project

### `OASJsonFilePath`

**Required** OAS Json file path relatively to your Github repo workspace, or you can give a URL as well

### `APIDefinitionFilePath`

**Required** API Definition yaml file path relatively to your Github repo workspace, or you can give a URL as well

### `APIVersion`

**Required** API Version

### `PostmanCollectionTestFile`

**Required** Here you can give a postman collection file to test the API before publishing into production tenant

## Example usage

```yaml
name: WSO2 APIManager Cloud CICD
on:
  push:
    branches: [main]

jobs:
  testing-actions:
    runs-on: ubuntu-latest

- name: APIM Cloud CICD
        uses: mihinduranasinghe/WSO2-APIManager-Cloud-CICD@v1.2.0
        id: apim
        with:
          usernameDevTenant: "mihindu@wso2.com@development"
          passwordDevTenant: ${{secrets.DEV_TENANT_PASSWORD}}
          usernameProdTenant: "mihindu@wso2.com@production"
          passwordProdTenant: ${{secrets.PROD_TENANT_PASSWORD}}
          APIProjectName: "SampleStore"
          OASJsonFilePath: "petstore.json"
          APIDefinitionFilePath: "api_template.yaml"
          APIVersion: "1.0.0"
          PostmanCollectionTestFile: "sample_store.postman_collection.json"
```
