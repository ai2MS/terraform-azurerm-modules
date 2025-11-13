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

locals {
  gateway_ip_configuration_name  = "vnet-gic"
  backend_address_pool_name      = "vnet-beap"
  frontend_port_name             = "vnet-feport"
  frontend_ip_configuration_name = "vnet-feip"
  http_setting_name              = "vnet-be-htst"
  listener_name                  = "vnet-httplstn"
  request_routing_rule_name      = "vnet-rqrt"
}

module "example_basic" {
  source = "../../application-gateway"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "agw-test"

  sku = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configurations = [
    {
      name      = local.gateway_ip_configuration_name
      subnet_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
    }
  ]

  frontend_ports = [
    {
      name = local.frontend_port_name
      port = 80
    }
  ]

  frontend_ip_configurations = [
    {
      name                 = local.frontend_ip_configuration_name
      public_ip_address_id = "pip-test"
    }
  ]

  backend_address_pools = [
    {
      name = local.backend_address_pool_name
    }
  ]

  backend_http_settings = [
    {
      name                  = local.http_setting_name
      cookie_based_affinity = "Disabled"
      path                  = "/path1/"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 60
    }
  ]

  http_listeners = [
    {
      name                           = local.listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = local.request_routing_rule_name
      priority                   = 9
      rule_type                  = "Basic"
      http_listener_name         = local.listener_name
      backend_address_pool_name  = local.backend_address_pool_name
      backend_http_settings_name = local.http_setting_name
    }
  ]
}

module "example_complete" {
  source = "../../application-gateway"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "agw-test"

  sku = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configurations = [
    {
      name      = local.gateway_ip_configuration_name
      subnet_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
    }
  ]

  frontend_ports = [
    {
      name = local.frontend_port_name
      port = 80
    }
  ]

  frontend_ip_configurations = [
    {
      name                            = local.frontend_ip_configuration_name
      subnet_id                       = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
      private_ip_address              = "10.0.2.12"
      public_ip_address_id            = "pip-test"
      private_ip_address_allocation   = "Static"
      private_link_configuration_name = "private-link-test"
    }
  ]

  backend_address_pools = [
    {
      name         = local.backend_address_pool_name
      fqdns        = ["fqdn-test"]
      ip_addresses = ["10.0.2.8"]
    }
  ]

  backend_http_settings = [
    {
      cookie_based_affinity               = "Disabled"
      affinity_cookie_name                = "affinitycookie"
      name                                = local.http_setting_name
      path                                = "/path1/"
      port                                = 80
      probe_name                          = "probe-test"
      protocol                            = "Http"
      request_timeout                     = 60
      host_name                           = "hostname-test"
      pick_host_name_from_backend_address = false
      trusted_root_certificate_names      = ["root-cert-test"]

      authentication_certificates = [
        {
          name = "auth-cert-test"
        }
      ]

      connection_draining = {
        enabled           = true
        drain_timeout_sec = 3
      }
    }
  ]

  http_listeners = [
    {
      name                           = local.listener_name
      frontend_ip_configuration_name = local.frontend_ip_configuration_name
      frontend_port_name             = local.frontend_port_name
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = local.request_routing_rule_name
      priority                   = 9
      rule_type                  = "Basic"
      http_listener_name         = local.listener_name
      backend_address_pool_name  = local.backend_address_pool_name
      backend_http_settings_name = local.http_setting_name
    }
  ]

  ssl_certificates = [
    {
      name     = "ssl-test-data"
      data     = "data"
      password = "password"
    },
    {
      name                = "ssl-test-key-vault"
      key_vault_secret_id = "https://myvault.vault.azure.net/secrets/mysecret"
    }
  ]

  probes = [
    {
      host                                      = "host"
      interval                                  = 3
      name                                      = "probe-test"
      protocol                                  = "Http"
      path                                      = "/"
      timeout                                   = 3
      unhealthy_threshold                       = 3
      port                                      = 8080
      pick_host_name_from_backend_http_settings = false
      minimum_servers                           = 1

      match = {
        body        = "body"
        status_code = [200, 201]
      }
    }
  ]

  redirect_configurations = [
    {
      name                 = "redirect-test-name"
      redirect_type        = "Permanent"
      target_listener_name = local.listener_name
      include_path         = true
      include_query_string = true
    },
    {
      name                 = "redirect-test-url"
      redirect_type        = "Temporary"
      target_url           = "url"
      include_path         = false
      include_query_string = false
    }
  ]

  custom_error_configurations = [
    {
      status_code           = "HttpStatus404"
      custom_error_page_url = "url"
    }
  ]

  private_link_configurations = [
    {
      name = "private-link-test"
      ip_configuration = [
        {
          name                          = "ipconfig-test-static"
          subnet_id                     = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
          private_ip_address_allocation = "Static"
          primary                       = true
          private_ip_address            = "10.0.2.8"
        },
        {
          name                          = "ipconfig-test-dynamic"
          subnet_id                     = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-test"
          private_ip_address_allocation = "Dynamic"
          primary                       = false
        }
      ]
    }
  ]

  enable_http2 = true

  enable_identity = true

  tags = {
    purpose = "example"
  }
}
