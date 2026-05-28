variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "rg-capstone"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "southeastasia"
}

variable "project_name" {
  description = "Project name used for tagging"
  type        = string
  default     = "Capstone"
}

variable "owner_name" {
  description = "Owner name used for tagging"
  type        = string
  default     = "Khairul"
}
