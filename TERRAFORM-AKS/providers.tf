# Configure the Azure Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
#  subscription_id = var.subscription_id  # Optional: uses Azure CLI default if null
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}