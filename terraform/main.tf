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

locals {
  common_tags = {
    project     = var.project_name
    environment = var.environment
    managed_by  = "terraform"
    purpose     = "devops-capstone"
  }
}

# -------------------------------------------------------------------
# Resource Group
# -------------------------------------------------------------------

resource "azurerm_resource_group" "capstone" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Azure Container Registry
# -------------------------------------------------------------------

resource "azurerm_container_registry" "capstone" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.capstone.name
  location            = azurerm_resource_group.capstone.location
  sku                 = var.acr_sku
  admin_enabled       = true

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Log Analytics Workspace for AKS Monitoring
# -------------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "capstone" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.capstone.location
  resource_group_name = azurerm_resource_group.capstone.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Azure Kubernetes Service
# -------------------------------------------------------------------

resource "azurerm_kubernetes_cluster" "capstone" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.capstone.location
  resource_group_name = azurerm_resource_group.capstone.name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Keeps Terraform aligned with the current live AKS configuration.
  oidc_issuer_enabled = true

  default_node_pool {
    name       = "system"
    node_count = var.aks_node_count
    vm_size    = var.aks_node_vm_size

    # Keeps Terraform aligned with the current live AKS node pool upgrade setting.
    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.capstone.id
  }

  tags = local.common_tags
}

# -------------------------------------------------------------------
# Allow AKS to pull images from ACR
# -------------------------------------------------------------------

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.capstone.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.capstone.kubelet_identity[0].object_id
}

# -------------------------------------------------------------------
# Storage Account for Future Product Images
# -------------------------------------------------------------------

resource "azurerm_storage_account" "product_images" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.capstone.name
  location                 = azurerm_resource_group.capstone.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true

  tags = local.common_tags
}

resource "azurerm_storage_container" "product_images" {
  name                  = var.product_images_container_name
  storage_account_name  = azurerm_storage_account.product_images.name
  container_access_type = "blob"
}