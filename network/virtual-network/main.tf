terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  address_space                  = var.address_space
  dns_servers                    = var.dns_servers
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering
resource "azurerm_virtual_network_peering" "main" {
  for_each = { for peering in var.peerings : peering.name => peering }

  virtual_network_name = azurerm_virtual_network.main.name

  resource_group_name = var.resource_group_name
  name                = each.value.name

  remote_virtual_network_id              = each.value.remote_virtual_network_id
  allow_virtual_network_access           = each.value.allow_virtual_network_access
  allow_forwarded_traffic                = each.value.allow_forwarded_traffic
  allow_gateway_transit                  = each.value.allow_gateway_transit
  local_subnet_names                     = each.value.local_subnet_names
  only_ipv6_peering_enabled              = each.value.only_ipv6_peering_enabled
  peer_complete_virtual_networks_enabled = each.value.peer_complete_virtual_networks_enabled
  remote_subnet_names                    = each.value.remote_subnet_names
  use_remote_gateways                    = each.value.use_remote_gateways
}
