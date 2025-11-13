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
| [azurerm_subnet.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_prefixes"></a> [address\_prefixes](#input\_address\_prefixes) | The address prefixes used for the subnet | `set(string)` | n/a | yes |
| <a name="input_default_outbound_access_enabled"></a> [default\_outbound\_access\_enabled](#input\_default\_outbound\_access\_enabled) | Determines whether default outbound access to the internet for the subnet is enabled | `bool` | `true` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | Configuration for subnet delegation | <pre>list(object({<br/>    name = string<br/>    service_delegation = object({<br/>      name    = string<br/>      actions = optional(set(string), null)<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_enable_network_security_group_association"></a> [enable\_network\_security\_group\_association](#input\_enable\_network\_security\_group\_association) | Enable the subnet to be associated with a network security group | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the subnet | `string` | n/a | yes |
| <a name="input_network_security_group_id"></a> [network\_security\_group\_id](#input\_network\_security\_group\_id) | Id of the network security group to associate with the subnet | `string` | `""` | no |
| <a name="input_private_endpoint_network_policies"></a> [private\_endpoint\_network\_policies](#input\_private\_endpoint\_network\_policies) | Enable or Disable network policies for the private endpoint on the subnet | `string` | `"Disabled"` | no |
| <a name="input_private_link_service_network_policies_enabled"></a> [private\_link\_service\_network\_policies\_enabled](#input\_private\_link\_service\_network\_policies\_enabled) | Enable or disable network policies for the private link service on the subnet | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the subnet will be created | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of service endpoints to associate with the subnet | `set(string)` | `null` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Name of the virtual network where the subnet will be created | `string` | n/a | yes |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_prefixes"></a> [address\_prefixes](#output\_address\_prefixes) | The address prefixes used for the subnet |
| <a name="output_default_outbound_access_enabled"></a> [default\_outbound\_access\_enabled](#output\_default\_outbound\_access\_enabled) | Determines whether default outbound access to the internet for the subnet is enabled |
| <a name="output_id"></a> [id](#output\_id) | The id of the subnet |
| <a name="output_name"></a> [name](#output\_name) | The name of the subnet |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the subnet is in |
| <a name="output_service_endpoints"></a> [service\_endpoints](#output\_service\_endpoints) | The list of service endpoints associated with the subnet |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the virtual network the subnet is in |

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