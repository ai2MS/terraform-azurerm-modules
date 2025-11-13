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
  source = "../../private-dns-zone"

  resource_group_name = "rg-test"
  name                = "example.com"
}

module "example_complete" {
  source = "../../private-dns-zone"

  resource_group_name = "rg-test"
  name                = "example.com"

  soa_record = {
    email         = "admin"
    host_name     = "test"
    expire_time   = 2419200
    minimum_ttl   = 300
    refresh_time  = 3600
    retry_time    = 300
    serial_number = 1
    ttl           = 3600
    tags = {
      purpose = "example"
    }
  }

  virtual_network_links = [
    {
      name                 = "test"
      virtual_network_id   = "vnet-test"
      registration_enabled = true
      resolution_policy    = "Default"
    }
  ]

  a_records = [
    {
      name    = "test"
      ttl     = 300
      records = ["10.0.180.17"]
    }
  ]

  aaaa_records = [
    {
      name    = "test"
      ttl     = 300
      records = ["2001:db8::1:0:0:1"]
    }
  ]

  cname_records = [
    {
      name   = "test"
      ttl    = 300
      record = "contoso.com"
    }
  ]

  txt_records = [
    {
      name = "test"
      ttl  = 300
      records = [
        {
          value = "google-site-authenticator"
        },
        {
          value = "more site information here"
        }
      ]
    }
  ]

  tags = {
    purpose = "example"
  }
}
