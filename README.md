# WSO2 APIManager Cloud CICD Action

This action allows WSO2 API Manager Cloud users to automate CICD

## Author

Mihindu Ranasinghe <br/>
<i>Trainee Software Engineer - WSO2 </i><br/>
<i>API Manager Cloud Team</i>

## How this works

In this version of APIMCloud CICD Action, you can automate creating an API project with given API definition and publish it in the development tenant. Then it can be tested with a postman collections.
If all checks passed, API project can be exported from the development tenant to the production tenant.

## Pre requesits

1. Create a github repository
2. Stage the API Definition file , OAS Json file and Postman Collection file into the local repository
3. Create a folder named ".github" in the root of the repository
4. Create a folder named "workflows" inside the ".github" folder.
5. Create a .yml file with any name , inside the "workflow" folder and you need to code as following example in that yml file
6. Replace the example input values with your details.
7. Values for the "passwordDevTenant" & "passwordProdTenant" must be stored in github repo secrets and use them as ${{secrets.SECRETPASSWORD}} both places
8. Push it into the main branch
9. go to the action section in the repo to see the CICD pipeline working

## Inputs

### `usernameDevTenant`

**Required** Dev tenant username as username@organization.com@DevtenantName

### `passwordDevTenant`

**Required** Dev tenant user's password should be stored in github repo secrets and use it here like ${{secrets.PASSWORD}}

### `usernameProdTenant`

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
  apim-cloud-cicd:
    runs-on: ubuntu-latest
    steps:
      - name: APIM Cloud CICD Public Action
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
