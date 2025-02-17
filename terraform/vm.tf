# Create Public IPs for VMs
resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.vm_count
  name                = var.vm_public_ip_names[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Standard"
}

# Create Network Interfaces for VMs
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${count.index}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[count.index].id
  }
}

# Create Virtual Machines
resource "azurerm_linux_virtual_machine" "vm" {
  count                 = var.vm_count
  name                  = var.vm_names[count.index]
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  disable_password_authentication = true

  # SSH Configuration
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("/home/dnt/az-master_public_key.pub")
  }

  # OS Disk
  os_disk {
    name                 = var.os_disk_names[count.index]
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  # Image Reference (Ubuntu)
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
