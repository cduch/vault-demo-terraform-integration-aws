#!/bin/sh
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# write the testpolicy policy
cat testpolicy.hcl | vault policy write testpolicy -

# create a service token with the policy and write it to a file
vault token create -format=json -policy=testpolicy -type="service" | jq -r ".auth.client_token" > test_token

# put that token into the tfvars, would be normaly stored in an ENV var for Terraform
echo "vaulttoken = \"$(cat test_token)\"" > tf/terraform.tfvars

# do some tests with that token
export VAULT_TOKEN=$(cat test_token)
vault token lookup

vault read  aws/sts/testrole role_arn="${AWS_ROLE_ARN}" ttl=15m