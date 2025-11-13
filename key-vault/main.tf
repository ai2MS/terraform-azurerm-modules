terraform {
	required_version = "~> 1.0"

	required_providers {
		azurerm = {
			source  = "hashicorp/azurerm"
			version = "~> 4.40.0"
		}
	}
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "main" {
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "main" {
  tenant_id = data.azurerm_client_config.main.tenant_id

  location                      = var.location
  resource_group_name           = var.resource_group_name
  name                          = var.name
  sku_name                      = var.sku_name
  purge_protection_enabled      = var.purge_protection_enabled
  public_network_access_enabled = var.public_network_access_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days

  dynamic "network_acls" {
    for_each = var.network_acls != null ? ["enabled"] : []

    content {
      bypass                     = var.network_acls.bypass
      default_action             = var.network_acls.default_action
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  rbac_authorization_enabled = true

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
resource "azurerm_key_vault_secret" "main" {
  for_each = nonsensitive(toset([for secret in var.secrets : secret.name]))

  key_vault_id = azurerm_key_vault.main.id

  name             = var.secrets[index(var.secrets.*.name, each.key)].name
  value            = var.secrets[index(var.secrets.*.name, each.key)].value
  value_wo         = var.secrets[index(var.secrets.*.name, each.key)].value_wo
  value_wo_version = var.secrets[index(var.secrets.*.name, each.key)].value_wo_version
  content_type     = var.secrets[index(var.secrets.*.name, each.key)].content_type
  not_before_date  = var.secrets[index(var.secrets.*.name, each.key)].not_before_date
  expiration_date  = var.secrets[index(var.secrets.*.name, each.key)].expiration_date

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate
resource "azurerm_key_vault_certificate" "main" {
  for_each = nonsensitive(toset([for certificate in var.certificates : certificate.name]))

  key_vault_id = azurerm_key_vault.main.id

  name = var.certificates[index(var.certificates.*.name, each.key)].name

  dynamic "certificate" {
    for_each = var.certificates[index(var.certificates.*.name, each.key)].certificate != null ? ["enabled"] : []

    content {
      contents = var.certificates[index(var.certificates.*.name, each.key)].certificate.contents
      password = var.certificates[index(var.certificates.*.name, each.key)].certificate.password
    }
  }

  dynamic "certificate_policy" {
    for_each = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy != null ? ["enabled"] : []

    content {
      issuer_parameters {
        name = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.issuer_parameters.name
      }

      key_properties {
        exportable = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.key_properties.exportable
        key_size   = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.key_properties.key_size
        key_type   = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.key_properties.key_type
        reuse_key  = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.key_properties.reuse_key
      }

      dynamic "lifetime_action" {
        for_each = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.lifetime_action != null ? ["enabled"] : []

        content {
          action {
            action_type = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.lifetime_action.action.action_type
          }

          trigger {
            days_before_expiry  = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.lifetime_action.trigger.days_before_expiry
            lifetime_percentage = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.lifetime_action.trigger.lifetime_percentage
          }
        }
      }

      secret_properties {
        content_type = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.secret_properties.content_type
      }

      dynamic "x509_certificate_properties" {
        for_each = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties != null ? ["enabled"] : []

        content {
          extended_key_usage = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.extended_key_usage
          key_usage          = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.key_usage
          subject            = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.subject
          validity_in_months = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.validity_in_months

          dynamic "subject_alternative_names" {
            for_each = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.subject_alternative_names != null ? ["enabled"] : []

            content {
              dns_names = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.subject_alternative_names.dns_names
              emails    = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.subject_alternative_names.emails
              upns      = var.certificates[index(var.certificates.*.name, each.key)].certificate_policy.x509_certificate_properties.subject_alternative_names.upns
            }
          }
        }
      }
    }
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_administrator" {
  for_each = toset(concat([data.azurerm_client_config.main.object_id], var.key_vault_administrator_principal_ids))

  role_definition_name = "Key Vault Administrator"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_reader" {
  for_each = toset(var.key_vault_reader_principal_ids)

  role_definition_name = "Key Vault Reader"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_certificates_officer" {
  for_each = toset(var.key_vault_certificates_officer_principal_ids)

  role_definition_name = "Key Vault Certificates Officer"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_certificate_user" {
  for_each = toset(var.key_vault_certificate_user_principal_ids)

  role_definition_name = "Key Vault Certificate User"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_secrets_officer" {
  for_each = toset(var.key_vault_secrets_officer_principal_ids)

  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "key_vault_secrets_user" {
  for_each = toset(var.key_vault_secrets_user_principal_ids)

  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.main.id

  principal_id = each.value
}
