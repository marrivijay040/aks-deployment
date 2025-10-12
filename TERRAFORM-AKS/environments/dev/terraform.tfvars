# Development Environment Configuration
# IMPORTANT: Replace with your actual Azure subscription ID
subscription_id = "beb7f423-8720-4489-9a09-59311e53d677" # Your Azure subscription ID

environment = "dev"
location = "Central India" # Mumbai - Best for India
resource_group_name = "rg-aks-dev"
cluster_name = "aks-dev-cluster"
node_count = 2
vm_size = "Standard_B2s" # Free tier eligible
kubernetes_version = "1.29"

tags = {
  Environment = "Development"
  Project = "AKS-Demo"
  Owner = "DevTeam"
  CostCenter = "Engineering"
}