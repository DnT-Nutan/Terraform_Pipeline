# Create Virtual Networks (VNETs)
resource "azurerm_virtual_network" "vnet" {
  count               = 2  # Creating exactly 2 VNETs
  name                = "apple-vnet-${count.index + 1}"  # Dynamic name like apple-vnet-1, apple-vnet-2
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_spaces[count.index]]  # Different address space for each VNET
}

# Create Subnets within each VNET (one subnet per VNET)
resource "azurerm_subnet" "subnet" {
  count                 = 2  # Creating exactly 1 subnet per VNET
  name                  = "apple-subnet-${count.index + 1}"  # Dynamic name like apple-subnet-1, apple-subnet-2
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.vnet[count.index].name  # Link to the corresponding VNET
  address_prefixes      = [var.subnet_address_prefixes[count.index]]  # Different address prefix for each subnet

  depends_on = [azurerm_virtual_network.vnet]
}

# Create Network Security Groups (NSGs)
resource "azurerm_network_security_group" "nsg" {
  count               = 2  # Creating exactly 2 NSGs
  name                = "apple-nsg-${count.index + 1}"  # Dynamic name like apple-nsg-1, apple-nsg-2
  location            = var.location
  resource_group_name = var.resource_group_name

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

# Network Interfaces (NICs)
resource "azurerm_network_interface" "nic" {
  count               = 2  # Creating exactly 2 NICs for each VM
  name                = "nic-${count.index + 1}"  # Dynamic name like nic-1, nic-2
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "new-ipconf-${count.index + 1}"  # Dynamic name like new-ipconf-1, new-ipconf-2
    subnet_id                     = azurerm_subnet.subnet[count.index].id  # Link to the corresponding subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[count.index].id  # Public IP for each NIC
  }
}

# Network Interface NSG Association
resource "azurerm_network_interface_security_group_association" "nic_nsg_association" {
  count                    = 2  # Associating 2 NICs with NSGs
  network_interface_id     = azurerm_network_interface.nic[count.index].id  # NIC ID
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id  # NSG ID
}
