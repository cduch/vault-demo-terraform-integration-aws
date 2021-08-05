path "aws/sts/testrole" {
    capabilities = ["read"]
}

path "auth/token/create" {
  capabilities = [ "update" ]
}