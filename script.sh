#!/bin/sh -l

# Environment Variables

    # $1 - usernameDevTenant
    # $2 - passwordDevTenant
    # $3 - usernameProdTenant
    # $4 - passwordProdTenant
    # $5 - APIProjectName
    # $6 - OASJsonFilePath
    # $7 - APIDefinitionFilePath
    # $8 - APIVersion

echo "::group::WSO2 APIMCLI Version"
    apimcli version
echo "::end-group"

echo "::group::WSO2 APIMCLI Help"
    apimcli --help
echo "::end-group"

echo "::group::WSO2 APIMCloud Tenants"
    echo Dev Tenant  - $1
    echo Prod tenant - $3
echo "::end-group"

echo "::group::Add environment wso2apicloud"
apimcli add-env -n wso2apicloud \
                      --registration https://gateway.api.cloud.wso2.com/client-registration/register \
                      --apim https://gateway.api.cloud.wso2.com/pulisher \
                      --token https://gateway.api.cloud.wso2.com/token \
                      --import-export https://gateway.api.cloud.wso2.com/api-import-export \
                      --admin https://gateway.api.cloud.wso2.com/api/am/admin/ \
                      --api_list https://gateway.api.cloud.wso2.com/api/am/publisher/apis \
                      --app_list https://gateway.api.cloud.wso2.com/api/am/store/applications

apimcli list envs          
echo "::end-group"

echo "::group::Init API iproject with given API definition"
    # apictl import-api -f $API_DIR -e $DEV_ENV -k --preserve-provider --update --verbose
    # apimcli init SampleStore --oas petstore.json --definition api_template.yaml
    apimcli init $5 --oas $6 --definition $7
echo "::end-group"

echo "::group::Push API project into the GIT repo from VM"
    git config --global user.email "my-bot@bot.com"
    git config --global user.name "my-bot"
    git add . 
    git commit -m "API project initialized"
    git push
echo "::end-group"


apimcli login wso2apicloud -u $1 -p $2 -k

    echo "::group::Import API project to Dev Tenant"
    apimcli import-api -f $GITHUB_WORKSPACE/$5 -e wso2apicloud --preserve-provider=false --update --verbose -k
    # apimcli logout wso2apicloud 
    echo "::end-group"

    echo "::group::List APIS in a Dev Tenant"
    # apimcli list apis -e <environment> -k
    # apimcli list apis --environment <environment> --insec# echo "::set-env name=HELLO::hello"ure
    apimcli list apis -e wso2apicloud -k
    echo "::end-group"


    echo "::group::Export API from Dev Tenant"
    # apimcli export-api -n <API-name> -v <version> -r <provider> -e <environment> -u <username> -p <password> -k
    # apimcli export-api --name <API-name> --version <version> --provider <provider> --environment <environment> --username <username> --password <password> --insecure
    # apimcli export-api -n TeamMasterAPI -v v1.0.0 -r mihindu@wso2.com@development -e wso2apicloud -k
    apimcli export-api -n $5 -v $8 -r $1 -e wso2apicloud -k
    echo "::end-group"

apimcli logout wso2apicloud 



apimcli login wso2apicloud -u $3 -p $4 -k

    echo "::group::Import API to Prod Tenant"
    # apimcli import-api -f <environment>/<file> -e <environment> -u <username> -p <password> --preserve-provider <preserve_provider> -k
    # apimcli import-api --file <environment>/<file> --environment <environment> --username <username> --password <password> --preserve-provider <preserve_provider> --insecure
    # apimcli import-api -f wso2apicloud/TeamMasterAPI_v1.0.0.zip -e wso2apicloud --preserve-provider=false -k
    apimcli import-api -f wso2apicloud/$5_$8.zip -e wso2apicloud --preserve-provider=false --update --verbose -k
    # apimcli logout wso2apicloud 
    echo "::end-group"

    echo "::group::List APIS in a Prod Tenant"
    # apimcli list apis -e <environment> -k
    # apimcli list apis --environment <environment> --insecure
    apimcli list apis -e wso2apicloud -k
    echo "::end-group"

apimcli logout wso2apicloud 



# echo "::group::Export an *App from current tenant"
# # apimcli export-app -n <application-name> -o <owner> -e <environment> -k
# # apimcli export-app --name <application-name> --owner <owner> --environment <environment> --insecure
# # apimcli export-app -n TestApp -o kim@wso2.com@testorg1 -e wso2apicloud -k
# echo "::end-group"

# echo "::group::Export an *App from current tenant"
# # apimcli export-app -n <application-name> -o <owner> -e <environment> -k
# # apimcli export-app --name <application-name> --owner <owner> --environment <environment> --insecure
# # apimcli export-app -n TestApp -o kim@wso2.com@testorg1 -e wso2apicloud -k
# echo "::end-group"

# echo "::group::List *Apps in a perticular environment"
# # apimcli list apps -e <environment> -o <owner> -k
# # apimcli list apps --environment <environment> --owner <owner> --insecure
# # apimcli list apps -e wso2apicloud -o admin -k
# echo "::end-group"

# echo "::group:: Reset Users"
# # If you want to list APIs or applications that belong to a particular tenant, 
# # you need to first reset the user before listing APIs or applications for the particular tenant.

# # apimcli reset-user -e <environment>
# # apimcli reset-user --environment <environment>
# # apimcli reset-user -e wso2apicloud
# echo "::end-group"

# echo "::group:: Set HTTP request timeout "
# # apimcli set --http-request-timeout <http-request-timeout>
# # apimcli set --http-request-timeout 10000
# echo "::end-group"

# echo "::group:: Set export directory "
# #Run the following CLI command to the change the default location of the export directory.
# # apimcli set --export-directory <export-directory-path>
# # apimcli set --export-directory /Users/kim/Downloads/MyExports
# echo "::end-group"

