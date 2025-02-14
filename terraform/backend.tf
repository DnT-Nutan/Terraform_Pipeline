terraform {
  backend "azurerm" {
    resource_group_name   = "backend-resource"
    storage_account_name  = "terrabackendstore"
    container_name        = "tf-backend-container"
    key                   = "terraform.tfstate"
  }
}
