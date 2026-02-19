terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "walmart-tfstate"
    storage_account_name = "walmarttfstate11897"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "walmart" {
  name     = "walmart-tfstate"
  location = "eastus"
}

resource "azurerm_storage_account" "walmarttfstate" {
  name                     = "walmarttfstate${random_integer.rand.result}"
  resource_group_name      = azurerm_resource_group.walmart.name
  location                 = azurerm_resource_group.walmart.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.walmarttfstate.id
  container_access_type = "private"
}
