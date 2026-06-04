terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
  }
}

provider "azurerm" {
  features {}
}

# -------------------------------------------------------------------
# The Shirt Bar Capstone - Terraform Reference
# -------------------------------------------------------------------
# This Terraform configuration is intentionally written as a SAFE
# reference configuration.
#
# It uses data sources to read existing Azure resources instead of
# creating or modifying resources.
#
# Do not run terraform apply before reviewing the configuration with
# the team and lecturer.
# -------------------------------------------------------------------

data "azurerm_resource_group" "capstone" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "capstone" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.capstone.name
}

data "azurerm_kubernetes_cluster" "capstone" {
  name                = var.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.capstone.name
}

# Optional future production resources can be added later, such as:
#
# - Azure Storage Account for product images
# - Azure Key Vault for application secrets
# - Azure Monitor / Log Analytics Workspace
# - Azure Application Gateway or Ingress Controller
# - Separate dev, staging, and production environments
#
# For this capstone, the file is used to demonstrate Infrastructure
# as Code structure without risking changes to the working Azure setup.
