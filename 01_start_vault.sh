#!/bin/sh
#stop and remove vault containers if already running

docker stop vault-demo-vault
docker rm vault-demo-vault

docker network rm dev-network

#start Vault in dev mode on port 8200
docker network create dev-network

touch log/vault_audit.log

#  get credentials from AWS and put them into ENV vars
doormat --refresh
eval $(doormat aws --account se_demos_dev)


# run docker container
docker run --name vault-demo-vault \
--network dev-network \
--privileged \
-e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
-e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
-e AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}" \
-p 8200:8200 \
--mount type=bind,source="$(pwd)"/log,target=/var/log \
hashicorp/vault-enterprise:1.7.3_ent \
server -dev -dev-root-token-id="root" &

export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root
export VAULT_NAMESPACE=

sleep 10 
# login with root token
vault login root

#write Vault Enterprise License (assuming it's already in a ENV Variable)
vault write sys/license text="${VAULT_LICENSE}"

# enable audit logging
vault audit disable file
vault audit enable file file_path=/var/log/vault_audit.log log_raw=true