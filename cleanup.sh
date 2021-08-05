#!/bin/sh

unset VAULT_ADDR VAULT_TOKEN

rm -rf \
    test_token \
    tf/.terraform \
    tf/.terraform.lock.hcl \
    tf/terraform.tfvars \
    log/vault_audit.log


#stop and remove vault containers if already running

docker stop vault-demo-vault
docker rm vault-demo-vault

docker network rm dev-network