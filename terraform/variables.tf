variable "project_name" {
  description = "Project name used for tagging Azure resources."
  type        = string
  default     = "the-shirt-bar-capstone"
}

variable "environment" {
  description = "Environment name for this Terraform deployment."
  type        = string
  default     = "staging"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group to create or manage."
  type        = string
  default     = "rg-capstone-tf-staging"
}

variable "location" {
  description = "Azure region used for the capstone infrastructure."
  type        = string
  default     = "southeastasia"
}

variable "acr_name" {
  description = "Globally unique Azure Container Registry name. Must contain only letters and numbers."
  type        = string
  default     = "capstonetfacr047af007"
}

variable "acr_sku" {
  description = "Azure Container Registry SKU."
  type        = string
  default     = "Basic"
}

variable "aks_cluster_name" {
  description = "Azure Kubernetes Service cluster name."
  type        = string
  default     = "capstone-aks-tf-staging"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
  default     = "capstoneakstfstaging"
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version. Leave as null to let Azure choose the default supported version."
  type        = string
  default     = null
}

variable "aks_node_count" {
  description = "Number of AKS nodes."
  type        = number
  default     = 1
}

variable "aks_node_vm_size" {
  description = "VM size for AKS node pool."
  type        = string
  default     = "Standard_B2s_v2"
}

variable "log_analytics_workspace_name" {
  description = "Name of Log Analytics Workspace for AKS monitoring."
  type        = string
  default     = "law-capstone-tf-staging"
}

variable "log_retention_days" {
  description = "Log Analytics retention in days."
  type        = number
  default     = 30
}

variable "storage_account_name" {
  description = "Globally unique Storage Account name for future product images. Must be lowercase letters and numbers only."
  type        = string
  default     = "tsbproductimg047af007"
}

variable "product_images_container_name" {
  description = "Blob container name for future product images."
  type        = string
  default     = "product-images"
}
