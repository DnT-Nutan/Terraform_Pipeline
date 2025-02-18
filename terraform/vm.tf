# Public IPs for VMs
resource "azurerm_public_ip" "vm_public_ip" {
  count               = 2  # Creating 2 Public IPs
  name                = "vm-public-ip-${var.vm_name[count.index]}"  # Unique name for each Public IP
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Standard"  # Set to Standard SKU for better performance
}

# Network Interfaces (NICs) for VMs (Example)
resource "azurerm_network_interface" "nic" {
  count               = 2  # Creating 2 NICs
  name                = "nic-${var.vm_name[count.index]}"  # Unique NIC name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${var.vm_name[count.index]}"  # Dynamic IP configuration name
    subnet_id                     = azurerm_subnet.subnet[count.index].id  # Link to the subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip[count.index].id  # Link the Public IP
  }
}

# Virtual Machines (VMs)
resource "azurerm_virtual_machine" "vm" {
  count                = 2  # Creating 2 VMs
  name                 = var.vm_name[count.index]  # Name for each VM
  location             = var.location
  resource_group_name  = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]  # Link to the NIC for each VM
  vm_size              = var.vm_size

  # OS Profile
  os_profile {
    computer_name  = var.vm_name[count.index]
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

  tags = {
    environment = "production"
  }
}

# Variables
variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "vm_name" {
  description = "The names for the VMs"
  type        = list(string)
}

variable "public_ip_allocation_method" {
  description = "The allocation method for Public IP (Dynamic or Static)"
  type        = string
  default     = "Dynamic"
}

variable "vm_size" {
  description = "The size of the virtual machines"
  type        = string
}

variable "admin_username" {
  description = "The administrator username for the VMs"
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the VMs"
  type        = string
  sensitive   = true
}

variable "os_disk_name" {
  description = "The name of the OS disk"
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the image for VM"
  type        = string
}

variable "image_offer" {
  description = "The offer of the image for VM"
  type        = string
}

variable "image_sku" {
  description = "The SKU of the image for VM"
  type        = string
}

variable "image_version" {
  description = "The version of the image for VM"
  type        = string
}
