# PostgreSQL Server
resource "azurerm_postgresql_server" "new_db_server" {
  name                         = var.postgresql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.postgresql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name     = var.sku_name
  storage_mb   = var.storage_mb
  ssl_enforcement_enabled = var.ssl_enforcement_enabled
}

# PostgreSQL Database
resource "azurerm_postgresql_database" "new_post_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.new_db_server.name
  charset             = var.database_charset
  collation           = var.database_collation
}

# Output: PostgreSQL Server Name
output "postgresql_server_name" {
  value = azurerm_postgresql_server.new_db_server.name
}

# Output: PostgreSQL Database Name
output "postgresql_database_name" {
  value = azurerm_postgresql_database.new_post_db.name
}
