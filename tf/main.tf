provider "vault" {
  address = "http://localhost:8200"
  token = var.vaulttoken
}

data "vault_aws_access_credentials" "creds" {
  backend                     = "aws"
  role                        = "testrole"
  type                        = "sts"
  ttl                         = "15m"
}

provider "aws" {
  region          = var.region
  access_key      = data.vault_aws_access_credentials.creds.access_key
  secret_key      = data.vault_aws_access_credentials.creds.secret_key
  token           = data.vault_aws_access_credentials.creds.security_token
}

# deployment of example VMs

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"

  tags = {
    Name  = var.name
    owner = "${var.owner}"
  }
}