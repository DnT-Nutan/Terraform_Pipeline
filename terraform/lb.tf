# Reference to an existing Public IP
resource "azurerm_public_ip" "dnt_public_ip" {
  name                = var.lb_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name  
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Standard"
}

# Reference the existing Resource Group and Load Balancer
resource "azurerm_lb" "new_lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  # First frontend IP configuration
  frontend_ip_configuration {
    name                 = "frontend-ip-1"
    public_ip_address_id = azurerm_public_ip.dnt_public_ip.id  
  }
}

# Create Backend Address Pool
resource "azurerm_lb_backend_address_pool" "new_lb_pool" {
  loadbalancer_id = azurerm_lb.new_lb.id
  name            = "new-pool"
}

# Create Load Balancer Probe
resource "azurerm_lb_probe" "new_lb_probe" {
  loadbalancer_id     = azurerm_lb.new_lb.id  
  name                = var.vmss_health_probe_name  
  port                = 80
  protocol            = "Http"  
  request_path        = "/"      
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Create Load Balancer Rule
resource "azurerm_lb_rule" "new_lb_rule" {
  loadbalancer_id                = azurerm_lb.new_lb.id
  name                           = "test-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name  = "frontend-ip-1"  
  probe_id                       = azurerm_lb_probe.new_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.new_lb_pool.id]
}

# Create Load Balancer Outbound Rule
resource "azurerm_lb_outbound_rule" "new_lb_outbound_rule" {
  loadbalancer_id         = azurerm_lb.new_lb.id  
  name                    = "test-outbound"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.new_lb_pool.id

  frontend_ip_configuration {
    name = "frontend-ip-1"  
  }
}
