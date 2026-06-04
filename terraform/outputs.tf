output "resource_group_name" {
  description = "Azure Resource Group used by the capstone project."
  value       = data.azurerm_resource_group.capstone.name
}

output "resource_group_location" {
  description = "Azure region of the capstone Resource Group."
  value       = data.azurerm_resource_group.capstone.location
}

output "acr_login_server" {
  description = "Azure Container Registry login server."
  value       = data.azurerm_container_registry.capstone.login_server
}

output "aks_cluster_name" {
  description = "AKS cluster name."
  value       = data.azurerm_kubernetes_cluster.capstone.name
}

output "aks_kubernetes_version" {
  description = "AKS Kubernetes version."
  value       = data.azurerm_kubernetes_cluster.capstone.kubernetes_version
}

output "aks_node_resource_group" {
  description = "AKS managed node resource group."
  value       = data.azurerm_kubernetes_cluster.capstone.node_resource_group
}
