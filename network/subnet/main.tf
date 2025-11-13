terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "main" {
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  name                                          = var.name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = var.service_endpoints
  default_outbound_access_enabled               = var.default_outbound_access_enabled
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled

  dynamic "delegation" {
    for_each = { for del in var.delegations : del.name => del }

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association
resource "azurerm_subnet_network_security_group_association" "main" {
  count = var.enable_network_security_group_association ? 1 : 0

  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = var.network_security_group_id
}
