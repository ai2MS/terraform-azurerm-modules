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
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_private_endpoint_application_security_group_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_security_group_id"></a> [application\_security\_group\_id](#input\_application\_security\_group\_id) | Id of the application security group to associate with the subnet | `string` | `""` | no |
| <a name="input_enable_application_security_group_association"></a> [enable\_application\_security\_group\_association](#input\_enable\_application\_security\_group\_association) | Enable the subnet to be associated with an application security group | `bool` | `false` | no |
| <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations) | This allows a static ip address to be set for this private endpoint, otherwise an address is dynamically allocated from the subnet | <pre>list(object({<br/>    name               = string<br/>    private_ip_address = string<br/>    subresource_name   = optional(string)<br/>    member_name        = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the private endpoint will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the private endpoint | `string` | n/a | yes |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | The private dns zone group to be used for this private endpoint | <pre>object({<br/>    name                 = string<br/>    private_dns_zone_ids = set(string)<br/>  })</pre> | `null` | no |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | The private service connection to be used for this private endpoint | <pre>object({<br/>    name                              = string<br/>    is_manual_connection              = bool<br/>    private_connection_resource_id    = optional(string)<br/>    private_connection_resource_alias = optional(string)<br/>    subresource_names                 = optional(set(string))<br/>    request_message                   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the private endpoint will be created | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The id of the subnet from which private ip addresses will be allocated for this private endpoint | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the private endpoint |
| <a name="output_ip_configurations"></a> [ip\_configurations](#output\_ip\_configurations) | The ip configurations of the private endpoint |
| <a name="output_name"></a> [name](#output\_name) | The name of the private endpoint |
| <a name="output_private_dns_zone_group"></a> [private\_dns\_zone\_group](#output\_private\_dns\_zone\_group) | The private dns zone group of the private endpoint |
| <a name="output_private_service_connection"></a> [private\_service\_connection](#output\_private\_service\_connection) | The private service connection of the private endpoint |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the private endpoint is in |

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