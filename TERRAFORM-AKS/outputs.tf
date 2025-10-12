output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "kube_config" {
  description = "Kubernetes configuration"
  value       = module.aks.kube_config
  sensitive   = true
}

output "cluster_fqdn" {
  description = "FQDN of the AKS cluster"
  value       = module.aks.cluster_fqdn
}

output "node_resource_group" {
  description = "Auto-generated resource group for AKS nodes"
  value       = module.aks.node_resource_group
}

output "cluster_identity" {
  description = "AKS cluster managed identity"
  value       = module.aks.cluster_identity
}