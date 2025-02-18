# Create VNets with random names and address space
resource "azurerm_virtual_network" "vnet" {
  count               = 2
  name                = "samsung-vnet-${random_id.vnet_name_suffix[count.index].hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [random_ip_range.vnet_address_range[count.index].cidr_block]
}

# Create Subnets with random names and address prefixes
resource "azurerm_subnet" "subnet" {
  count                = 2
  name                 = "subnet-${random_id.subnet_name_suffix[count.index].hex}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet[count.index].name
  address_prefixes     = [random_ip_range.subnet_address_range[count.index].cidr_block]
  depends_on = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name   = var.resource_group_name

  # Allow SSH traffic on port 22
  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTP traffic on port 80
  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTPS traffic on port 443
  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "new-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "new-ipconf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id  
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
