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
  source = "../../virtual-network"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "vnet-test"
}

module "example_complete" {
  source = "../../virtual-network"

  location                       = "centralus"
  resource_group_name            = "rg-test"
  name                           = "vnet-test"
  address_space                  = ["10.0.0.0/16"]
  dns_servers                    = ["10.0.0.4", "10.0.0.5"]
  private_endpoint_vnet_policies = "Basic"

  peerings = [
    {
      name                                   = "peer-test"
      remote_virtual_network_id              = "vnet-remote-id"
      allow_virtual_network_access           = true
      allow_forwarded_traffic                = false
      allow_gateway_transit                  = false
      local_subnet_names                     = ["snet-test"]
      only_ipv6_peering_enabled              = false
      peer_complete_virtual_networks_enabled = true
      remote_subnet_names                    = ["snet-remote"]
      use_remote_gateways                    = false
    }
  ]

  tags = {
    purpose = "example"
  }
}
