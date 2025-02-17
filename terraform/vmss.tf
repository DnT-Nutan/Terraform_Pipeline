resource "azurerm_virtual_machine_scale_set" "new_vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.vmss_sku
    tier     = "Standard"
    capacity = var.vmss_instance_count
  }

  # Upgrade Policy
  upgrade_policy_mode = var.vmss_upgrade_policy  

  # OS Profile
  os_profile {
    computer_name_prefix = var.vmss_name
    admin_username       = var.admin_username
    admin_password       = var.admin_password
  }

  # Linux Configuration
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = file("/home/dnt/az-master_public_key.pub")
    }
  }
  # Network Profile
  network_profile {
    name    = "networkprofile"
    primary = true

    ip_configuration {
      name      = "ipconfig"
      subnet_id = azurerm_subnet.subnet.id
      primary   = true
      # Attach to Load Balancer's backend pool
      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.new_lb_pool.id
      ]
    }
  }

  # OS Disk Configuration 
  storage_profile_os_disk {
    caching           = "ReadWrite"        
    create_option     = "FromImage"        
    managed_disk_type = "Standard_LRS"     
  }

  # Image Reference (Ubuntu image)
  storage_profile_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}

# Output the VMSS ID
output "vmss_id" {
  value = azurerm_virtual_machine_scale_set.new_vmss.id
}

# Output the Public IP ID
output "public_ip_id" {
  value = azurerm_public_ip.dnt_public_ip.id
}
