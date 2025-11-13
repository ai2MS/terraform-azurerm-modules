output "id" {
  description = "The id of the application gateway"
  value       = azurerm_application_gateway.main.id
}

output "name" {
  description = "The name of the application gateway"
  value       = azurerm_application_gateway.main.name
}

output "location" {
  description = "The location of the application gateway"
  value       = azurerm_application_gateway.main.location
}

output "resource_group_name" {
  description = "The name of the resource group the application gateway is in"
  value       = azurerm_application_gateway.main.resource_group_name
}

