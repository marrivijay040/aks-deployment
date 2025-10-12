# Random suffix for unique naming
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.cluster_name}-${var.environment}-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.cluster_name}-${var.environment}-dns"
  #kubernetes_version  = var.kubernetes_version

  # Free tier friendly configuration
  sku_tier = "Free"

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    type                = "VirtualMachineScaleSets"
    
    # Free tier optimizations
    max_pods            = 30
    os_disk_size_gb     = 30  # Minimum for cost optimization
    os_disk_type        = "Managed"
    
    # Network configuration
    vnet_subnet_id = azurerm_subnet.aks.id
  }

  # Managed Identity
  identity {
    type = "SystemAssigned"
  }

  # Network profile
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    service_cidr       = "172.16.0.0/16"     # Non-overlapping service CIDR
    dns_service_ip     = "172.16.0.10"       # Must be within service_cidr
  }

  # Disable features to reduce costs
  role_based_access_control_enabled = true
  
  tags = merge(var.tags, {
    Environment = var.environment
    Component   = "AKS"
  })

  depends_on = [
    azurerm_subnet.aks
  ]
}

# Virtual Network for AKS
resource "azurerm_virtual_network" "aks" {
  name                = "vnet-${var.cluster_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = merge(var.tags, {
    Environment = var.environment
    Component   = "Network"
  })
}

# Subnet for AKS nodes
resource "azurerm_subnet" "aks" {
  name                 = "subnet-${var.cluster_name}-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Role assignment for AKS to access the subnet
resource "azurerm_role_assignment" "aks_network" {
  principal_id                     = azurerm_kubernetes_cluster.main.identity[0].principal_id
  role_definition_name             = "Network Contributor"
  scope                           = azurerm_subnet.aks.id
  skip_service_principal_aad_check = true
}