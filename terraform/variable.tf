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

# Variable for the virtual network
variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "apple-vnet"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Variable for the subnet
variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "apple-subnet"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# Variable for the storage account
variable "storage_account_name" {
  description = "The name of the Azure Storage Account."
  type        = string
  default     = "teresangyarrstorage"
}

variable "account_tier" {
  description = "The performance tier of the storage account (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the storage account (e.g., LRS, GRS, RA-GRS)."
  type        = string
  default     = "LRS"
}

variable "storage_container_name" {
  description = "The name of the container in the storage account."
  type        = string
  default     = "apple-containerstore"
}

# Variable for Kubernetes cluster
variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "apple-aks-cluster"
}

variable "aks_node_pool_vm_size" {
  description = "The VM size for the AKS node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "aks_node_pool_count" {
  description = "The number of nodes in the AKS node pool."
  type        = number
  default     = 1
}

# Variable for PostgreSQL Server
variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
  default     = "apple-postserver"
}

variable "postgresql_version" {
  description = "The version of the PostgreSQL server."
  type        = string
  default     = "11"
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL server."
  type        = string
  default     = "pgadmin"
}

variable "administrator_login_password" {
  description = "The password for the administrator login."
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "The name of the PostgreSQL database."
  type        = string
  default     = "appledbpostgres"
}

variable "ssl_enforcement_enabled" {
  description = "Whether SSL enforcement is enabled for the PostgreSQL server."
  type        = bool
  default     = true
}
