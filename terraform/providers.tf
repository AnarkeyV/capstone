provider "azurerm" {
  features {}
}

locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "devops-capstone"
  }
}
