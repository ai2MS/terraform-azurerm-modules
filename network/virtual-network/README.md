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
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_peering.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network | `set(string)` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of DNS servers to use for the virtual network | `set(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the virtual network will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the virtual network | `string` | n/a | yes |
| <a name="input_peerings"></a> [peerings](#input\_peerings) | List of peering configurations to be connected to the virtual network | <pre>list(object({<br/>    name                                   = string<br/>    remote_virtual_network_id              = string<br/>    allow_virtual_network_access           = optional(bool, true)<br/>    allow_forwarded_traffic                = optional(bool, false)<br/>    allow_gateway_transit                  = optional(bool, false)<br/>    local_subnet_names                     = optional(set(string))<br/>    only_ipv6_peering_enabled              = optional(bool)<br/>    peer_complete_virtual_networks_enabled = optional(bool, true)<br/>    remote_subnet_names                    = optional(set(string))<br/>    use_remote_gateways                    = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_private_endpoint_vnet_policies"></a> [private\_endpoint\_vnet\_policies](#input\_private\_endpoint\_vnet\_policies) | List of DNS servers to use for the virtual network | `string` | `"Disabled"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the virtual network will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The address space of the virtual network |
| <a name="output_guid"></a> [guid](#output\_guid) | The guid of the virtual network |
| <a name="output_id"></a> [id](#output\_id) | The id of the virtual network |
| <a name="output_location"></a> [location](#output\_location) | The location of the virtual network |
| <a name="output_name"></a> [name](#output\_name) | The name of the virtual network |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the virtual network is in |

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