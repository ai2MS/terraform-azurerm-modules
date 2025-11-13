output "id" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "location" {
  description = "The location of the virtual network"
  value       = azurerm_virtual_network.main.location
}

output "resource_group_name" {
  description = "The name of the resource group the virtual network is in"
  value       = azurerm_virtual_network.main.resource_group_name
}

output "address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.main.address_space
}

output "guid" {
  description = "The guid of the virtual network"
  value       = azurerm_virtual_network.main.guid
}
