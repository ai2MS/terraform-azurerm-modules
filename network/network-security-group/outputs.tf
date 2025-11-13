output "id" {
  description = "The id of the network security group"
  value       = azurerm_network_security_group.main.id
}

output "name" {
  description = "The name of the network security group"
  value       = azurerm_network_security_group.main.name
}

output "location" {
  description = "The location of the network security group"
  value       = azurerm_network_security_group.main.location
}

output "resource_group_name" {
  description = "The name of the resource group the network security group is in"
  value       = azurerm_network_security_group.main.resource_group_name
}
