output "id" {
  description = "The id of the resource group"
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.main.location
}

output "name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}
