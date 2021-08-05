#!/bin/sh

# trigger terraform to init and plan with the previously created token
cd tf
terraform init

terraform plan