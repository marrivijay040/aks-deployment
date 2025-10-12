# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.tags, {
    Environment = var.environment
    Project     = "AKS-MultiEnv"
    ManagedBy   = "Terraform"
  })
}

# Use the AKS module
module "aks" {
  source = "./modules/aks"

  environment         = var.environment
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  cluster_name       = var.cluster_name
  node_count         = var.node_count
  vm_size           = var.vm_size
  kubernetes_version = var.kubernetes_version
  tags              = var.tags

  depends_on = [azurerm_resource_group.main]
}