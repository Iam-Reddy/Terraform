terraform {
     required_version = ">= 1.14.4"

required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "~> 4.60.0"
  }
}

}
provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "walmart" {
  name     = "walmart-resources"
  location = "east US"
}

resource "azurerm_storage_account" "walmart" {
  name                     = "walmartstorageaccount"
  resource_group_name      = azurerm_resource_group.walmart.name
  location                 = azurerm_resource_group.walmart.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}