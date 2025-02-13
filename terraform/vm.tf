resource "azurerm_public_ip" "vm_public_ip" {
  name                = var.vm_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name  
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Standard"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  # OS Profile
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  # Linux Configuration
  os_profile_linux_config {
    disable_password_authentication = true

    # Specify the SSH public key
    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = file("/home/dnt/az-master_public_key.pub") 
    }
  }

  # OS Disk
  storage_os_disk {
    name          = var.os_disk_name
    caching       = "ReadWrite"
    create_option = "FromImage"
    disk_size_gb  = 30
  }

  # Image Reference for Ubuntu
  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

