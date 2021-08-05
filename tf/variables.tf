variable "name" { 
  default = "temporary-test-vm" 
}
variable "region" {
  default = "eu-central-1" 
}
variable "owner" {
  default = "carsten@hashicorp.com"
}

variable "vaulttoken" {
  type = string
}