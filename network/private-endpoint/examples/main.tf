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
  subscription_id = "a50bb4bb-0c03-4859-b9c0-4a0ad3ffee3a"

  features {}
}

module "example_basic" {
  source = "../../private-endpoint"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "pep-test"

  subnet_id = "snet-test"
}

module "example_complete" {
  source = "../../private-endpoint"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "pep-test"

  subnet_id = "snet-test"

  private_service_connection = {
    name                           = "psc-test"
    is_manual_connection           = false
    private_connection_resource_id = "vnet-test"
    subresource_names              = ["subnet"]
  }

  private_dns_zone_group = {
    name                 = "pdng-test"
    private_dns_zone_ids = ["dnszone-test"]
  }

  ip_configurations = [
    {
      name               = "pipconfig1"
      private_ip_address = "10.0.2.4"
      subresource_name   = "name"
      member_name        = "name"
    },
    {
      name               = "pipconfig2"
      private_ip_address = "10.0.2.5"
    }
  ]

  enable_application_security_group_association = true
  application_security_group_id                 = "asg-test"

  tags = {
    purpose = "example"
  }
}
