output "id" {
  description = "The id of the private endpoint"
  value       = azurerm_private_endpoint.main.id
}

output "name" {
  description = "The name of the private endpoint"
  value       = azurerm_private_endpoint.main.name
}

output "resource_group_name" {
  description = "The name of the resource group the private endpoint is in"
  value       = azurerm_private_endpoint.main.resource_group_name
}

output "private_service_connection" {
  description = "The private service connection of the private endpoint"
  value       = azurerm_private_endpoint.main.resource_group_name
}

output "private_dns_zone_group" {
  description = "The private dns zone group of the private endpoint"
  value       = azurerm_private_endpoint.main.resource_group_name
}

output "ip_configurations" {
  description = "The ip configurations of the private endpoint"
  value       = azurerm_private_endpoint.main.resource_group_name
}
