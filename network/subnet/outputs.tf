output "id" {
  description = "The id of the subnet"
  value       = azurerm_subnet.main.id
}

output "name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.main.name
}

output "resource_group_name" {
  description = "The name of the resource group the subnet is in"
  value       = azurerm_subnet.main.resource_group_name
}

output "virtual_network_name" {
  description = "The name of the virtual network the subnet is in"
  value       = azurerm_subnet.main.virtual_network_name
}

output "address_prefixes" {
  description = "The address prefixes used for the subnet"
  value       = azurerm_subnet.main.address_prefixes
}

output "service_endpoints" {
  description = "The list of service endpoints associated with the subnet"
  value       = azurerm_subnet.main.service_endpoints
}

output "default_outbound_access_enabled" {
  description = "Determines whether default outbound access to the internet for the subnet is enabled"
  value       = azurerm_subnet.main.default_outbound_access_enabled
}
