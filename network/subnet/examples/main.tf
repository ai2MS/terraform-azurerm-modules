terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "example_basic" {
  source = "../../subnet"

  resource_group_name  = "rg-test"
  virtual_network_name = "vnet-test"
  name                 = "snet-test"
  address_prefixes     = ["10.0.1.0/24"]
}

module "example_complete" {
  source = "../../subnet"

  resource_group_name                           = "rg-test"
  virtual_network_name                          = "vnet-test"
  name                                          = "snet-test"
  address_prefixes                              = ["10.0.1.0/24"]
  service_endpoints                             = ["Microsoft.Storage", "Microsoft.ServiceBus"]
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true

  delegations = [
    {
      name = "delegation"
      service_delegation = {
        name    = "Microsoft.ContainerInstance/containerGroups"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
  ]
}
