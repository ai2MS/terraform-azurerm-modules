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
  source = "../../network-security-group"

  location            = "centralus"
  name                = "nsg-test"
  resource_group_name = "rg-test"
}

module "example_complete" {
  source = "../../network-security-group"

  location            = "centralus"
  name                = "nsg-test"
  resource_group_name = "rg-test"

  inbound_rules = [
    {
      name                                  = "nsgsr-inbound-test-001"
      description                           = "test nsg inbound rule 001"
      priority                              = 100
      access                                = "Deny"
      protocol                              = "Icmp"
      source_port_range                     = "*"
      destination_port_range                = "*"
      source_address_prefix                 = "*"
      destination_address_prefix            = "*"
      source_application_security_group_ids = ["asg-test"]
    },
    {
      name                                       = "nsgsr-inbound-test-002"
      description                                = "test nsg inbound rule 002"
      priority                                   = 200
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_ranges                         = ["9200", "9300"]
      destination_port_ranges                    = ["5601", "8220"]
      source_address_prefixes                    = ["13.107.6.0/24", "13.107.9.0/24"]
      destination_address_prefixes               = ["150.171.75.0/24", "150.171.76.0/24"]
      destination_application_security_group_ids = ["asg-test"]
    }
  ]

  outbound_rules = [
    {
      name                                  = "nsgsr-outbound-test-001"
      description                           = "test nsg outbound rule 001"
      priority                              = 100
      access                                = "Deny"
      protocol                              = "Icmp"
      source_port_range                     = "*"
      destination_port_range                = "*"
      source_address_prefix                 = "*"
      destination_address_prefix            = "Internet"
      source_application_security_group_ids = ["asg-test"]
    },
    {
      name                                       = "nsgsr-outbound-test-002"
      description                                = "test nsg outbound rule 002"
      priority                                   = 200
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_ranges                         = ["9200", "9300"]
      destination_port_ranges                    = ["5601", "8220"]
      source_address_prefixes                    = ["13.107.6.0/24", "13.107.9.0/24"]
      destination_address_prefixes               = ["150.171.75.0/24", "150.171.76.0/24"]
      destination_application_security_group_ids = ["asg-test"]
    }
  ]

  tags = {
    purpose = "example"
  }
}
