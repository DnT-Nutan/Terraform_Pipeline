# Azure Container Registry
resource "azurerm_container_registry" "new_acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku

  admin_enabled       = true  
}

# Output the login server URL
output "acr_login_server" {
  value = azurerm_container_registry.new_acr.login_server
}