############
# S3 Backend
############

terraform {
  required_version = "~> 0.12.0"
  backend "azurerm" {
    resource_group_name  = "ops-tfstate-rg"
    storage_account_name = "osptfstatest"
    container_name       = "tfstates"
    environment          = "${environment_name}"
    key                  = "${environment}-${name}.tfstate"
  }
}

######################
# Deployment variables
######################

module "deploy" {
  source        = "s3::https://s3.amazonaws.com/safefleet-terraform-artifacts/${name}-config-${version}.zip"
  location      = "${location}"
  environment   = "${environment}"
  customer      = "${customer}"
  image_version = "${image_version}"
  cloud         = "${cloud}"
}