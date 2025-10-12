variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"  # Free tier friendly region
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 2
  validation {
    condition     = var.node_count >= 1 && var.node_count <= 3
    error_message = "Node count must be between 1 and 3 for free tier."
  }
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_B2s"  # Free tier eligible
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = null  # Will use Azure CLI default if not provided
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}