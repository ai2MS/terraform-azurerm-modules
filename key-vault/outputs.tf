output "location" {
  description = "The location of the key vault"
  value       = azurerm_key_vault.main.location
}

output "resource_group_name" {
  description = "The resource group name of the key vault"
  value       = azurerm_key_vault.main.resource_group_name
}

output "id" {
  description = "The id of the key vault"
  value       = azurerm_key_vault.main.id
}

output "name" {
  description = "The name of the key vault"
  value       = azurerm_key_vault.main.name
}

output "sku_name" {
  description = "The SKU name of the key vault"
  value       = azurerm_key_vault.main.sku_name
}

output "purge_protection_enabled" {
  description = "Determines whether purge protection is enabled for this key vault"
  value       = azurerm_key_vault.main.purge_protection_enabled
}

output "public_network_access_enabled" {
  description = "Determines whether public network access is allowed for this key vault"
  value       = azurerm_key_vault.main.purge_protection_enabled
}

output "soft_delete_retention_days" {
  description = "Number of days that items of this key vault should be retained for once soft-deleted"
  value       = azurerm_key_vault.main.soft_delete_retention_days
}

output "network_acls" {
  description = "Network acl configuration for the key vault"
  value       = azurerm_key_vault.main.network_acls
}

output "secrets" {
  description = "Information about the key vault secrets managed by this module"
  value = {
    for secret in azurerm_key_vault_secret.main : secret.name => {
      id                      = secret.id
      name                    = secret.name
      resource_versionless_id = secret.resource_versionless_id
      version                 = secret.version
    }
  }
}

output "certificates" {
  description = "Information about the key vault certificates managed by this module"
  value = {
    for certificate in azurerm_key_vault_certificate.main : certificate.name => {
      id                              = certificate.id
      name                            = certificate.name
      secret_id                       = certificate.secret_id
      version                         = certificate.version
      certificate_data                = certificate.certificate_data
      certificate_data_base64         = certificate.certificate_data_base64
      thumbprint                      = certificate.thumbprint
      resource_manager_versionless_id = certificate.resource_manager_versionless_id
    }
  }
}
