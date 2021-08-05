# HashiCorp Vault Enterprise & Terraform: Demo scenario on using Vault with Terraform

Requires a valid Vault enterprise license in $VAULT_LICENSE
Requires the AWS ARN ROLE to be set within in $AWS_ROLE_ARNS

1. Starts Vault in a Docker container
2. Configures AWS secret engine in vault with an assumed role config
3. Creates a token for Terraform and exports this token as a terraform variable
4. Configures an approle for an vault agent to auto generate certificates via vault agent


for more info, follow this guide:
https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/interactive

and read this:
https://www.vaultproject.io/docs/agent/template#renewals-and-updating-secrets