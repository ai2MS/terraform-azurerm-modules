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
| [azurerm_network_security_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.inbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_inbound_rules"></a> [inbound\_rules](#input\_inbound\_rules) | A list of inbound network security rules to be associated with the network security group | <pre>set(object({<br/>    name                                       = string<br/>    description                                = string<br/>    priority                                   = number<br/>    access                                     = string<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(set(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(set(string))<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(set(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(set(string))<br/>    source_application_security_group_ids      = optional(set(string))<br/>    destination_application_security_group_ids = optional(set(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the network security group will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the network security group | `string` | n/a | yes |
| <a name="input_outbound_rules"></a> [outbound\_rules](#input\_outbound\_rules) | A list of outbound network security rules to be associated with the network security group | <pre>set(object({<br/>    name                                       = string<br/>    description                                = string<br/>    priority                                   = number<br/>    access                                     = string<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string)<br/>    source_port_ranges                         = optional(set(string))<br/>    destination_port_range                     = optional(string)<br/>    destination_port_ranges                    = optional(set(string))<br/>    source_address_prefix                      = optional(string)<br/>    source_address_prefixes                    = optional(set(string))<br/>    destination_address_prefix                 = optional(string)<br/>    destination_address_prefixes               = optional(set(string))<br/>    source_application_security_group_ids      = optional(set(string))<br/>    destination_application_security_group_ids = optional(set(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the network security group will be created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the network security group |
| <a name="output_location"></a> [location](#output\_location) | The location of the network security group |
| <a name="output_name"></a> [name](#output\_name) | The name of the network security group |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the network security group is in |

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