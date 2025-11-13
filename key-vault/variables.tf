variable "location" {
  description = "Azure region where the key vault will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the key vault will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the key vault"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "sku_name" {
  description = "Name of the sku used for this key vault"
  type        = string
  nullable    = false
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "invalid sku_name value"
  }
}

variable "purge_protection_enabled" {
  description = "Determines whether purge protection is enabled for this key vault"
  type        = bool
  default     = null
}

variable "public_network_access_enabled" {
  description = "Determines whether public network access is allowed for this key vault"
  type        = bool
  nullable    = false
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Number of days that items of this key vault should be retained for once soft-deleted"
  type        = number
  nullable    = false
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "invalid soft_delete_retention_days value"
  }
}

variable "network_acls" {
  description = "Network acl configuration for the key vault"
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(set(string), null)
    virtual_network_subnet_ids = optional(set(string), null)
  })
  default = null
}

variable "secrets" {
  description = "A list of secrets to be added to the key vault"
  type = list(object({
    name             = string
    value            = optional(string)
    value_wo         = optional(string)
    value_wo_version = optional(number)
    content_type     = optional(string)
    not_before_date  = optional(string)
    expiration_date  = optional(string)
  }))
  default   = []
  sensitive = true
}

variable "certificates" {
  description = "A list of certificates to be added to the key vault"
  type = list(object({
    name = string
    certificate = optional(object({
      contents = string
      password = optional(string)
    }))
    certificate_policy = optional(object({
      issuer_parameters = object({
        name = string
      })

      key_properties = object({
        exportable = bool
        key_size   = number
        key_type   = string
        reuse_key  = bool
      })

      lifetime_action = optional(object({
        action = object({
          action_type = string
        })
        trigger = object({
          days_before_expiry  = optional(number)
          lifetime_percentage = optional(number)
        })
      }))

      secret_properties = object({
        content_type = string
      })

      x509_certificate_properties = optional(object({
        extended_key_usage = optional(set(string))
        key_usage          = set(string)
        subject_alternative_names = optional(object({
          dns_names = optional(set(string))
          emails    = optional(set(string))
          upns      = optional(set(string))
        }))
        subject            = string
        validity_in_months = number
      }))
    }))
  }))
  default   = []
  sensitive = true
}

variable "key_vault_administrator_principal_ids" {
  description = "List of principle ids to be granted the key vault administrator role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_vault_reader_principal_ids" {
  description = "List of principle ids to be granted the key vault reader role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_vault_certificates_officer_principal_ids" {
  description = "List of principle ids to be granted the key vault certificates officer role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_vault_certificate_user_principal_ids" {
  description = "List of principle ids to be granted the key vault certificate user role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_vault_secrets_officer_principal_ids" {
  description = "List of principle ids to be granted the key vault secrets officer role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_vault_secrets_user_principal_ids" {
  description = "List of principle ids to be granted the key vault secret user role for this key vault"
  type        = list(string)
  nullable    = false
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
