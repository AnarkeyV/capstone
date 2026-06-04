output "resource_group_name" {
  description = "Resource Group name."
  value       = azurerm_resource_group.capstone.name
}

output "acr_login_server" {
  description = "Azure Container Registry login server."
  value       = azurerm_container_registry.capstone.login_server
}

output "aks_cluster_name" {
  description = "AKS cluster name."
  value       = azurerm_kubernetes_cluster.capstone.name
}

output "aks_node_resource_group" {
  description = "AKS managed node resource group."
  value       = azurerm_kubernetes_cluster.capstone.node_resource_group
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = azurerm_log_analytics_workspace.capstone.name
}

output "storage_account_name" {
  description = "Storage Account name for future product images."
  value       = azurerm_storage_account.product_images.name
}

output "product_images_container_name" {
  description = "Blob container name for future product images."
  value       = azurerm_storage_container.product_images.name
}

output "product_images_base_url" {
  description = "Base URL for product image blobs."
  value       = "https://${azurerm_storage_account.product_images.name}.blob.core.windows.net/${azurerm_storage_container.product_images.name}"
}
