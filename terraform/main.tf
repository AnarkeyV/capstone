# ============================================
# TERRAFORM CONFIGURATION
# ============================================
# This block tells Terraform which version of itself
# and which providers (plugins) we need.
# It runs LOCALLY on my MacBook during terraform init.
# ============================================

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  # Optional: Store Terraform state in Azure Storage (production best practice)
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "tfstatecapstone"
  #   container_name       = "tfstate"
  #   key                  = "capstone.tfstate"
  # }
}

# ============================================
# PROVIDER CONFIGURATION
# ============================================
# This configures the Azure provider specifically.
# The empty 'features' block is required.
# It tells Azure we accept default behaviors.
# ============================================

provider "azurerm" {
  features {}
  
  # Optional: Add tags to all resources for cost tracking
  # default_tags {
  #   tags = {
  #     Project     = "Capstone"
  #     Environment = "Development"
  #     ManagedBy   = "Terraform"
  #     Owner       = "Khairul"
  #   }
  # }
}

# ============================================
# RESOURCE GROUP
# ============================================
# This is the container for ALL resources in this project.
# Think of it as a folder that holds everything.
# When I delete this group, everything inside is deleted.
# ============================================

resource "azurerm_resource_group" "capstone" {
  name     = "rg-capstone"
  location = "southeastasia"
  
  # Tags help identify costs in Azure billing
  tags = {
    Project = "Capstone"
    Owner   = "Khairul"
  }
}

# ============================================
# OUTPUTS (for presentation visibility)
# ============================================
# Outputs print information after terraform apply.
# Useful for getting resource names for later steps.
# ============================================

output "resource_group_name" {
  value       = azurerm_resource_group.capstone.name
  description = "The name of the resource group containing all resources"
}

output "resource_group_location" {
  value       = azurerm_resource_group.capstone.location
  description = "The Azure region where resources are deployed"
}