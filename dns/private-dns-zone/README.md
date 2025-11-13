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
| [azurerm_private_dns_a_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_aaaa_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) | resource |
| [azurerm_private_dns_cname_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_txt_record.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_a_records"></a> [a\_records](#input\_a\_records) | List of a records to be added to the private dns zone | <pre>list(object({<br/>    name    = string<br/>    ttl     = number<br/>    records = set(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_aaaa_records"></a> [aaaa\_records](#input\_aaaa\_records) | List of aaaa records to be added to the private dns zone | <pre>list(object({<br/>    name    = string<br/>    ttl     = number<br/>    records = set(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_cname_records"></a> [cname\_records](#input\_cname\_records) | List of cname records to be added to the private dns zone | <pre>list(object({<br/>    name   = string<br/>    ttl    = number<br/>    record = string<br/>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the private dns zone | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the private dns zone will be created | `string` | n/a | yes |
| <a name="input_soa_record"></a> [soa\_record](#input\_soa\_record) | Details of the soa record used for the private dns zone | <pre>object({<br/>    email         = string<br/>    host_name     = optional(string)<br/>    expire_time   = optional(number, 2419200)<br/>    minimum_ttl   = optional(number, 300)<br/>    refresh_time  = optional(number, 3600)<br/>    retry_time    = optional(number, 300)<br/>    serial_number = optional(number, 1)<br/>    ttl           = optional(number, 3600)<br/>    tags          = optional(map(string))<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |
| <a name="input_txt_records"></a> [txt\_records](#input\_txt\_records) | List of txt records to be added to the private dns zone | <pre>list(object({<br/>    name = string<br/>    ttl  = number<br/>    records = list(object({<br/>      value = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links) | List of virtual network links to be added to the private dns zone | <pre>list(object({<br/>    name                 = string<br/>    virtual_network_id   = string<br/>    registration_enabled = optional(bool, false)<br/>    resolution_policy    = optional(string)<br/>  }))</pre> | `[]` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_a_records"></a> [a\_records](#output\_a\_records) | A list of a records in the private dns zone |
| <a name="output_aaaa_records"></a> [aaaa\_records](#output\_aaaa\_records) | A list of aaaa records in the private dns zone |
| <a name="output_cname_records"></a> [cname\_records](#output\_cname\_records) | A list of cname records in the private dns zone |
| <a name="output_id"></a> [id](#output\_id) | The id of the private dns zone |
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | Maximum number of records in the private dns zone |
| <a name="output_max_number_of_virtual_network_links"></a> [max\_number\_of\_virtual\_network\_links](#output\_max\_number\_of\_virtual\_network\_links) | The maximum number of virtual networks that can be linked to this private dns zone |
| <a name="output_max_number_of_virtual_network_links_with_registration"></a> [max\_number\_of\_virtual\_network\_links\_with\_registration](#output\_max\_number\_of\_virtual\_network\_links\_with\_registration) | The maximum number of virtual networks that can be linked to this private dns zone with registration enabled |
| <a name="output_name"></a> [name](#output\_name) | The name of the private dns zone |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The number of records already in the zone |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group the private dns zone is in |
| <a name="output_txt_records"></a> [txt\_records](#output\_txt\_records) | A list of txt records in the private dns zone |

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