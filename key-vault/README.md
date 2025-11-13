# Terraform module documentation 

This documentation is generated using [terraform-docs](https://terraform-docs.io/user-guide/introduction) 
and contains helpful information about the module's usage.

---

## 📦 Providers used

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.45.0 |

## 🧰 Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.45.0 |

## 🧩 Modules included

## Modules

No modules.

## 🏗️ Resources created

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_certificate.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_secret.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_role_assignment.key_vault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_certificate_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_certificates_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_secrets_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.key_vault_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## 🔧 Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificates"></a> [certificates](#input\_certificates) | A list of certificates to be added to the key vault | <pre>list(object({<br/>    name = string<br/>    certificate = optional(object({<br/>      contents = string<br/>      password = optional(string)<br/>    }))<br/>    certificate_policy = optional(object({<br/>      issuer_parameters = object({<br/>        name = string<br/>      })<br/><br/>      key_properties = object({<br/>        exportable = bool<br/>        key_size   = number<br/>        key_type   = string<br/>        reuse_key  = bool<br/>      })<br/><br/>      lifetime_action = optional(object({<br/>        action = object({<br/>          action_type = string<br/>        })<br/>        trigger = object({<br/>          days_before_expiry  = optional(number)<br/>          lifetime_percentage = optional(number)<br/>        })<br/>      }))<br/><br/>      secret_properties = object({<br/>        content_type = string<br/>      })<br/><br/>      x509_certificate_properties = optional(object({<br/>        extended_key_usage = optional(set(string))<br/>        key_usage          = set(string)<br/>        subject_alternative_names = optional(object({<br/>          dns_names = optional(set(string))<br/>          emails    = optional(set(string))<br/>          upns      = optional(set(string))<br/>        }))<br/>        subject            = string<br/>        validity_in_months = number<br/>      }))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_key_vault_administrator_principal_ids"></a> [key\_vault\_administrator\_principal\_ids](#input\_key\_vault\_administrator\_principal\_ids) | List of principle ids to be granted the key vault administrator role for this key vault | `list(string)` | `[]` | no |
| <a name="input_key_vault_certificate_user_principal_ids"></a> [key\_vault\_certificate\_user\_principal\_ids](#input\_key\_vault\_certificate\_user\_principal\_ids) | List of principle ids to be granted the key vault certificate user role for this key vault | `list(string)` | `[]` | no |
| <a name="input_key_vault_certificates_officer_principal_ids"></a> [key\_vault\_certificates\_officer\_principal\_ids](#input\_key\_vault\_certificates\_officer\_principal\_ids) | List of principle ids to be granted the key vault certificates officer role for this key vault | `list(string)` | `[]` | no |
| <a name="input_key_vault_reader_principal_ids"></a> [key\_vault\_reader\_principal\_ids](#input\_key\_vault\_reader\_principal\_ids) | List of principle ids to be granted the key vault reader role for this key vault | `list(string)` | `[]` | no |
| <a name="input_key_vault_secrets_officer_principal_ids"></a> [key\_vault\_secrets\_officer\_principal\_ids](#input\_key\_vault\_secrets\_officer\_principal\_ids) | List of principle ids to be granted the key vault secrets officer role for this key vault | `list(string)` | `[]` | no |
| <a name="input_key_vault_secrets_user_principal_ids"></a> [key\_vault\_secrets\_user\_principal\_ids](#input\_key\_vault\_secrets\_user\_principal\_ids) | List of principle ids to be granted the key vault secret user role for this key vault | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the key vault will be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the key vault | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | Network acl configuration for the key vault | <pre>object({<br/>    bypass                     = string<br/>    default_action             = string<br/>    ip_rules                   = optional(set(string), null)<br/>    virtual_network_subnet_ids = optional(set(string), null)<br/>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Determines whether public network access is allowed for this key vault | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Determines whether purge protection is enabled for this key vault | `bool` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group where the key vault will be created | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A list of secrets to be added to the key vault | <pre>list(object({<br/>    name             = string<br/>    value            = optional(string)<br/>    value_wo         = optional(string)<br/>    value_wo_version = optional(number)<br/>    content_type     = optional(string)<br/>    not_before_date  = optional(string)<br/>    expiration_date  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Name of the sku used for this key vault | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | Number of days that items of this key vault should be retained for once soft-deleted | `number` | `90` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources | `map(string)` | `null` | no |

## 📤 Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificates"></a> [certificates](#output\_certificates) | Information about the key vault certificates managed by this module |
| <a name="output_id"></a> [id](#output\_id) | The id of the key vault |
| <a name="output_location"></a> [location](#output\_location) | The location of the key vault |
| <a name="output_name"></a> [name](#output\_name) | The name of the key vault |
| <a name="output_network_acls"></a> [network\_acls](#output\_network\_acls) | Network acl configuration for the key vault |
| <a name="output_public_network_access_enabled"></a> [public\_network\_access\_enabled](#output\_public\_network\_access\_enabled) | Determines whether public network access is allowed for this key vault |
| <a name="output_purge_protection_enabled"></a> [purge\_protection\_enabled](#output\_purge\_protection\_enabled) | Determines whether purge protection is enabled for this key vault |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The resource group name of the key vault |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | Information about the key vault secrets managed by this module |
| <a name="output_sku_name"></a> [sku\_name](#output\_sku\_name) | The SKU name of the key vault |
| <a name="output_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#output\_soft\_delete\_retention\_days) | Number of days that items of this key vault should be retained for once soft-deleted |

---

## Example

```hcl
terraform {
  required_version = "~> 1.12.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.45.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "a50bb4bb-0c03-4859-b9c0-4a0ad3ffee3a"

  features {}
}

module "example_basic" {
  source = "../../key-vault"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "kv-test"
}

module "example_complete" {
  source = "../../key-vault"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "kv-test"

  sku_name                      = "standard"
  purge_protection_enabled      = true
  public_network_access_enabled = true
  soft_delete_retention_days    = 90

  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = ["175.157.41.138"]
    virtual_network_subnet_ids = ["snet-test"]
  }

  secrets = [
    {
      name            = "secret-test-01"
      value           = "secret-test-value-01"
      content_type    = "text/plain"
      not_before_date = "2025-07-20T00:00:00Z"
    },
    {
      name             = "secret-test-02"
      value_wo         = "secret-test-value-02"
      value_wo_version = 1
      content_type     = "text/plain"
      expiration_date  = "2025-12-31T23:59:59Z"
    }
  ]

  certificates = [
    {
      name = "certificate-test-01"

      certificate = {
        contents = "base-64-string"
        password = "PASSWORD"
      }
    },
    {
      name = "certificate-test-02"

      certificate_policy = {
        issuer_parameters = {
          name = "Self"
        }

        key_properties = {
          exportable = true
          key_size   = 2048
          key_type   = "RSA"
          reuse_key  = true
        }

        lifetime_action = {
          action = {
            action_type = "AutoRenew"
          }

          trigger = {
            days_before_expiry = 30
          }
        }

        secret_properties = {
          content_type = "application/x-pkcs12"
        }

        x509_certificate_properties = {
          # Server Authentication = 1.3.6.1.5.5.7.3.1
          # Client Authentication = 1.3.6.1.5.5.7.3.2
          extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

          key_usage = [
            "cRLSign",
            "dataEncipherment",
            "digitalSignature",
            "keyAgreement",
            "keyCertSign",
            "keyEncipherment",
          ]

          subject_alternative_names = {
            dns_names = ["internal.contoso.com", "domain.hello.world"]
            emails    = ["admin@contoso.com"]
            upns      = ["admin"]
          }

          subject            = "CN=hello-world"
          validity_in_months = 12
        }
      }
    }
  ]

  key_vault_administrator_principal_ids        = ["00000000-0000-0000-0000-000000000000"]
  key_vault_reader_principal_ids               = ["00000000-0000-0000-0000-000000000000"]
  key_vault_certificates_officer_principal_ids = ["00000000-0000-0000-0000-000000000000"]
  key_vault_certificate_user_principal_ids     = ["00000000-0000-0000-0000-000000000000"]
  key_vault_secrets_officer_principal_ids      = ["00000000-0000-0000-0000-000000000000"]
  key_vault_secrets_user_principal_ids         = ["00000000-0000-0000-0000-000000000000"]

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