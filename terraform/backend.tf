terraform {
  backend "azurerm" {
    resource_group_name  = "rg-capstone-tfstate"
    storage_account_name = "capstonetfstate047af007"
    container_name       = "tfstate"
    key                  = "staging.terraform.tfstate"
  }
}