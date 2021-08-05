#!/bin/sh

export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

# enable AWS secret engine
vault secrets disable aws
vault secrets enable aws


# write the role "testrole" for the ARNS stored in the ENV Var $AWS_ROLE_ARNS

vault write aws/roles/testrole role_arns=${AWS_ROLE_ARNS} credential_type=assumed_role default_sts_ttl=14m59s max_sts_ttl=59m59s

# test write to get a temp sts token
#vault write aws/sts/testrole ttl=15m