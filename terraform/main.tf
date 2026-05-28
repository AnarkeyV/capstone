# ============================================
# TERRAFORM CONFIGURATION
# ============================================

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# ============================================
# PROVIDER CONFIGURATION
# ============================================

provider "azurerm" {
  features {}
}

# ============================================
# RESOURCE GROUP
# ============================================

resource "azurerm_resource_group" "capstone" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Project = var.project_name
    Owner   = var.owner_name
  }
}

# ============================================
# OUTPUTS
# ============================================

output "resource_group_name" {
  value       = azurerm_resource_group.capstone.name
  description = "The name of the resource group containing all resources"
}

output "resource_group_location" {
  value       = azurerm_resource_group.capstone.location
  description = "The Azure region where resources are deployed"
}
