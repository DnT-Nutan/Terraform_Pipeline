# Variable for the resource group name
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "apple-resources"
}

# Variable for the location
variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default     = "West US 2"
}

# Variable for the virtual network names
variable "vnet_names" {
  description = "The names of the virtual networks."
  type        = list(string)
  default     = ["apple-vnet-1", "apple-vnet-2"]
}

# Variable for the address space of the virtual networks
variable "vnet_address_spaces" {
  description = "The address spaces for the virtual networks."
  type        = list(string)
  default     = ["10.0.0.0/16", "10.1.0.0/16"]
}

# Variable for the subnet names
variable "subnet_names" {
  description = "The names of the subnets."
  type        = list(string)
  default     = ["apple-subnet-1", "apple-subnet-2"]
}

# Variable for the address prefix of the subnets
variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.1.1.0/24"]
}

# Variable for the Network Security Group (NSG) names
variable "nsg_names" {
  description = "The names of the network security groups."
  type        = list(string)
  default     = ["apple-nsg-1", "apple-nsg-2"]
}

# Variable for the virtual machine name
variable "vm_name" {
  description = "The names of the virtual machines."
  type        = list(string)
  default     = ["apple-vm-1", "apple-vm-2"]
}

# Variable for the public IP allocation method
variable "public_ip_allocation_method" {
  description = "The allocation method of the public IP."
  type        = string
  default     = "Static"
}

# Variable for the VM size
variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_DS1_v2"
}

# Variable for the OS disk name
variable "os_disk_name" {
  description = "The name of the OS disk."
  type        = string
  default     = "os-disk"
}

# Variable for the admin username and password
variable "admin_username" {
  description = "The administrator username."
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "The administrator password."
  type        = string
  default     = "yourpassword123!"
}

# Variable for the Ubuntu image details
variable "image_publisher" {
  description = "The publisher of the image."
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "The offer of the image."
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "The SKU of the image."
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "The version of the image."
  type        = string
  default     = "latest"
}

# Variable for DNS Zone Name
variable "dns_zone_name" {
  description = "The name of the DNS zone."
  type        = string
  default     = "test.p.frii.site" 
}

# Variable for Azure Container Registry Name
variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
  default     = "tujanenarepo"  
}

# Variable for Azure Container Registry SKU
variable "acr_sku" {
  description = "The SKU of the Azure Container Registry."
  type        = string
  default     = "Basic"  
}

# Variable for Virtual Machine Scale Set Name
variable "vmss_name" {
  description = "The name of the Virtual Machine Scale Set."
  type        = string
  default     = "apple-vmss"  
}

# Variable for VMSS SKU
variable "vmss_sku" {
  description = "The SKU of the Virtual Machine Scale Set."
  type        = string
  default     = "Standard_B2s"
}

# Variable for the number of instances in the VMSS
variable "vmss_instance_count" {
  description = "The number of instances in the Virtual Machine Scale Set."
  type        = number
  default     = 2
}

# Variable for the VMSS upgrade policy
variable "vmss_upgrade_policy" {
  description = "The upgrade policy for the Virtual Machine Scale Set."
  type        = string
  default     = "Manual"
}

# Variable for the VMSS health probe name
variable "vmss_health_probe_name" {
  description = "The name of the health probe for the VMSS."
  type        = string
  default     = "apple-health-probe"
}

# Variable for the VMSS load balancer name
variable "vmss_load_balancer_name" {
  description = "The name of the load balancer for the VMSS."
  type        = string
  default     = "apple-load-balancer"
}

# Variable for the VMSS network interface name
variable "vmss_nic_name" {
  description = "The name of the network interface for the VMSS."
  type        = string
  default     = "apple-vmss-nic"
}

# Variable for the VMSS network security group name
variable "vmss_nsg_name" {
  description = "The name of the network security group for the VMSS."
  type        = string
  default     = "apple-vmss-nsg"
}

# Variable for Load Balancer
variable "load_balancer_name" {
  description = "Name of the Load Balancer."
  type        = string
  default     = "apple-lb"
}

# Variable for the storage account name
variable "storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
  default     = "teresangyarrstorage"
}

# Variable for the storage account tier
variable "account_tier" {
  description = "The performance tier of the storage account (Standard or Premium)."
  type        = string
  default     = "Standard"
}

# Variable for the storage account replication type
variable "account_replication_type" {
  description = "The replication type of the storage account (e.g., LRS, GRS, RA-GRS)."
  type        = string
  default     = "LRS"
}

# Variable for the container name
variable "storage_container_name" {
  description = "The name of the container in the storage account."
  type        = string
  default     = "apple-containerstore" 
}

# Variable for New subnet
variable "subnet_new_name" {
  description = "The name of the subnet for the Kubernetes cluster."
  type        = string
  default     = "apple-public-subnet"
}

# Variable for the address prefix of the new public subnet
variable "public_subnet_address_prefix" {
  description = "The address prefix for the new public subnet."
  type        = string
  default     = "10.0.2.0/24"  
}

# AKS Cluster Name
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "apple-aks-cluster"
}

# AKS DNS Name Prefix
variable "aks_dns_name_prefix" {
  description = "The DNS name prefix for the AKS cluster."
  type        = string
  default     = "aks"
}

# AKS Node Pool Name
variable "aks_node_pool_name" {
  description = "The name of the AKS node pool."
  type        = string
  default     = "nodepool" 
}

# AKS Node Pool VM Size
variable "aks_node_pool_vm_size" {
  description = "The VM size for the AKS node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

# AKS Node Pool Count
variable "aks_node_pool_count" {
  description = "The number of nodes in the AKS node pool."
  type        = number
  default     = 1
}

# Variables for PostgreSQL Server Configuration
variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
  default     = "apple-postserver"
}

variable "postgresql_version" {
  description = "The version of the PostgreSQL server"
  type        = string
  default     = "11"
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server"
  type        = string
  default     = "pgadmin"
}

variable "administrator_login_password" {
  description = "The password for the administrator login"
  type        = string
  sensitive   = true
  default     = "pass$00000"
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server"
  type        = string
  default     = "B_Gen5_1"
}

variable "storage_mb" {
  description = "The storage size in MB for the PostgreSQL server"
  type        = number
  default     = 5120
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
  default     = "appledbpostgres"
}

variable "database_charset" {
  description = "The character set for the PostgreSQL database"
  type        = string
  default     = "UTF8"
}

variable "database_collation" {
  description = "The collation for the PostgreSQL database"
  type        = string
  default     = "English_United States.1252"
}

variable "high_availability_mode" {
  description = "The high availability mode for the PostgreSQL server"
  type        = string
  default     = "None"  
}

# SSL enforcement for the PostgreSQL server
variable "ssl_enforcement_enabled" {
  description = "Whether SSL enforcement is enabled for the PostgreSQL server"
  type        = bool
  default     = true
}
