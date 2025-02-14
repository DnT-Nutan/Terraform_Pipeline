terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.17"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "backend-resource"
    storage_account_name  = "terrabackendstore"
    container_name        = "tf-backend-container"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d49e6059-7e63-4b1d-b093-492b8a94c5cb"
}

# Azure Resource Group
resource "azurerm_resource_group" "dell" {
  name     = var.resource_group_name
  location = var.location
}
