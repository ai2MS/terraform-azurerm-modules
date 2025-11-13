# Terraform module documentation 

This documentation is generated using [terraform-docs](https://terraform-docs.io/user-guide/introduction) 
and contains helpful information about the module's usage.

---

## 📦 Providers used

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.40.0 |

## 🧰 Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.40.0 |

## 🧩 Modules included

## Modules

No modules.

## 🏗️ Resources created

## Resources

| Name | Type |
|------|------|
| [azurerm_application_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | Backend address pools of the application gateway | <pre>list(object({<br/>    name         = string<br/>    fqdns        = optional(set(string))<br/>    ip_addresses = optional(set(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | Backend http settings of the application gateway | <pre>list(object({<br/>    cookie_based_affinity               = optional(string)<br/>    affinity_cookie_name                = optional(string)<br/>    name                                = string<br/>    path                                = optional(string)<br/>    port                                = number<br/>    probe_name                          = optional(string)<br/>    protocol                            = string<br/>    request_timeout                     = optional(number, 30)<br/>    host_name                           = optional(string)<br/>    pick_host_name_from_backend_address = optional(bool, false)<br/>    trusted_root_certificate_names      = optional(set(string))<br/><br/>    authentication_certificates = optional(list(object({<br/>      name = string<br/>    })), [])<br/><br/>    connection_draining = optional(object({<br/>      enabled           = bool<br/>      drain_timeout_sec = optional(number)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_custom_error_configurations"></a> [custom\_error\_configurations](#input\_custom\_error\_configurations) | Custom error configurations used by the application gateway | <pre>list(object({<br/>    status_code           = string<br/>    custom_error_page_url = string<br/>  }))</pre> | `[]` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | Determines whether http2 is enabled on the application gateway | `bool` | `false` | no |
| <a name="input_enable_identity"></a> [enable\_identity](#input\_enable\_identity) | Determines whether managed identity is enabled on the application gateway | `bool` | `false` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | Frontend ip configurations of the application gateway | <pre>list(object({<br/>    name                            = string<br/>    subnet_id                       = optional(string)<br/>    private_ip_address              = optional(string)<br/>    public_ip_address_id            = optional(string)<br/>    private_ip_address_allocation   = optional(string, "Dynamic")<br/>    private_link_configuration_name = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | Frontend ports of the application gateway | <pre>list(object({<br/>    name = string<br/>    port = number<br/>  }))</pre> | `[]` | no |
| <a name="input_gateway_ip_configurations"></a> [gateway\_ip\_configurations](#input\_gateway\_ip\_configurations) | Gateway ip configurations of the application gateway | <pre>list(object({<br/>    name      = string<br/>    subnet_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | HTTP listeners of the application gateway | <pre>list(object({<br/>    name                           = string<br/>    frontend_ip_configuration_name = string<br/>    frontend_port_name             = string<br/>    host_name                      = optional(string)<br/>    host_names                     = optional(set(string))<br/>    protocol                       = string<br/>    require_sni                    = optional(bool, false)<br/>    ssl_certificate_name           = optional(string)<br/>    firewall_policy_id             = optional(string)<br/>    ssl_profile_name               = optional(string)<br/><br/>    custom_error_configurations = optional(list(object({<br/>      status_code           = string<br/>      custom_error_page_url = string<br/>    })), [])<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the application gateway will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the application gateway | `string` | n/a | yes |
| <a name="input_private_link_configurations"></a> [private\_link\_configurations](#input\_private\_link\_configurations) | Private link configurations used by the application gateway | <pre>list(object({<br/>    name = string<br/>    ip_configuration = list(object({<br/>      name                          = string<br/>      subnet_id                     = string<br/>      private_ip_address_allocation = string<br/>      primary                       = bool<br/>      private_ip_address            = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_probes"></a> [probes](#input\_probes) | Probes used by the application gateway | <pre>list(object({<br/>    host                                      = optional(string)<br/>    interval                                  = number<br/>    name                                      = string<br/>    protocol                                  = string<br/>    path                                      = string<br/>    timeout                                   = number<br/>    unhealthy_threshold                       = number<br/>    port                                      = optional(number)<br/>    pick_host_name_from_backend_http_settings = optional(bool, false)<br/>    minimum_servers                           = optional(number, 0)<br/><br/>    match = optional(object({<br/>      body        = string<br/>      status_code = list(number)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_redirect_configurations"></a> [redirect\_configurations](#input\_redirect\_configurations) | Redirect configurations used by the application gateway | <pre>list(object({<br/>    name                 = string<br/>    redirect_type        = string<br/>    target_listener_name = optional(string)<br/>    target_url           = optional(string)<br/>    include_path         = optional(bool, false)<br/>    include_query_string = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_request_routing_rules"></a> [request\_routing\_rules](#input\_request\_routing\_rules) | Request routing rules of the application gateway | <pre>list(object({<br/>    name                        = string<br/>    rule_type                   = string<br/>    http_listener_name          = string<br/>    backend_address_pool_name   = optional(string)<br/>    backend_http_settings_name  = optional(string)<br/>    redirect_configuration_name = optional(string)<br/>    rewrite_rule_set_name       = optional(string)<br/>    url_path_map_name           = optional(string)<br/>    priority                    = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the application gateway will be created | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the application gateway | <pre>object({<br/>    name     = string<br/>    tier     = string<br/>    capacity = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | SSL certificates used by the application gateway | <pre>list(object({<br/>    name                = string<br/>    data                = optional(string)<br/>    password            = optional(string)<br/>    key_vault_secret_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the application gateway |
| <a name="output_location"></a> [location](#output\_location) | The location of the application gateway |
| <a name="output_name"></a> [name](#output\_name) | The name of the application gateway |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the application gateway is in |

---

## Example

```hcl
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
```

---

## 📚 Useful links

References to relevant documentations.

- [Terraform](https://developer.hashicorp.com/terraform/docs)
- [Terraform azurerm provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Microsoft Azure](https://portal.azure.com)
- [Microsoft Entra](https://entra.microsoft.com)
- [Azure DevOps](https://dev.azure.com/sudheera-jayasinghe)
- [Azure resource naming](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Azure resource abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) 