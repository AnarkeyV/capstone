variable "resource_group_name" {
  description = "Name of the Azure Resource Group used for the capstone project."
  type        = string
  default     = "rg-capstone"
}

variable "location" {
  description = "Azure region used for the capstone project."
  type        = string
  default     = "southeastasia"
}

variable "acr_name" {
  description = "Azure Container Registry name."
  type        = string
  default     = "capstonereg047af007"
}

variable "aks_cluster_name" {
  description = "Azure Kubernetes Service cluster name."
  type        = string
  default     = "capstone-aks"
}

variable "project_name" {
  description = "Project name used for documentation and tagging."
  type        = string
  default     = "the-shirt-bar-capstone"
}
