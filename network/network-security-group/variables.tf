variable "location" {
  description = "Azure region where the network security group will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the network security group will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the network security group"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "inbound_rules" {
  description = "A list of inbound network security rules to be associated with the network security group"
  type = set(object({
    name                                       = string
    description                                = string
    priority                                   = number
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(set(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(set(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(set(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(set(string))
    source_application_security_group_ids      = optional(set(string))
    destination_application_security_group_ids = optional(set(string))
  }))
  nullable = false
  default  = []
}

variable "outbound_rules" {
  description = "A list of outbound network security rules to be associated with the network security group"
  type = set(object({
    name                                       = string
    description                                = string
    priority                                   = number
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(set(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(set(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(set(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(set(string))
    source_application_security_group_ids      = optional(set(string))
    destination_application_security_group_ids = optional(set(string))
  }))
  nullable = false
  default  = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
