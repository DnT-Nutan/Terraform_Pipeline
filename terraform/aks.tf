resource "azurerm_subnet" "public_subnet" {
  name                 = var.subnet_new_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_prefix]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_dns_name_prefix

  default_node_pool {
    name       = var.aks_node_pool_name
    node_count = var.aks_node_pool_count
    vm_size    = var.aks_node_pool_vm_size
    vnet_subnet_id = azurerm_subnet.public_subnet.id
  }

  identity {
    type = "SystemAssigned" 
  }

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file("/home/dnt/az-master_public_key.pub")  
    }
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.1.0.0/16"  
    dns_service_ip = "10.1.0.10"
  }
  depends_on = [azurerm_container_registry.new_acr]  
}
# Grant AKS Managed Identity access to ACR using Azure Role Assignment
resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = azurerm_container_registry.new_acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  skip_service_principal_aad_check = true
}

# Output for kube_config
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config
  sensitive = true
}