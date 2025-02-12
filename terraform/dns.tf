# Azure DNS Zone
resource "azurerm_dns_zone" "new_dns" {
  name                = var.dns_zone_name  
  resource_group_name = var.resource_group_name
}
