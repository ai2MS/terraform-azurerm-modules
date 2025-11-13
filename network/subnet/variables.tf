variable "resource_group_name" {
  description = "Name of the resource group where the subnet will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "virtual_network_name" {
  description = "Name of the virtual network where the subnet will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.virtual_network_name) > 0
    error_message = "virtual_network_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the subnet"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "address_prefixes" {
  description = "The address prefixes used for the subnet"
  type        = set(string)
  nullable    = false

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "address_prefixes cannot be empty"
  }
}

variable "service_endpoints" {
  description = "The list of service endpoints to associate with the subnet"
  type        = set(string)
  default     = null
}

variable "default_outbound_access_enabled" {
  description = "Determines whether default outbound access to the internet for the subnet is enabled"
  type        = bool
  nullable    = false
  default     = true
}

variable "private_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private endpoint on the subnet"
  type        = string
  nullable    = false
  default     = "Disabled"

  validation {
    condition = contains([
      "Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"
    ], var.private_endpoint_network_policies)
    error_message = "invalid private_endpoint_network_policies value"
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Enable or disable network policies for the private link service on the subnet"
  type        = bool
  nullable    = false
  default     = true
}

variable "delegations" {
  description = "Configuration for subnet delegation"
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(set(string), null)
    })
  }))
  default = []
}

variable "enable_network_security_group_association" {
  description = "Enable the subnet to be associated with a network security group"
  type        = bool
  nullable    = false
  default     = false
}

variable "network_security_group_id" {
  description = "Id of the network security group to associate with the subnet"
  type        = string
  nullable    = false
  default     = ""

  validation {
    condition     = var.enable_network_security_group_association ? (length(var.network_security_group_id) > 0) : true
    error_message = "if enable_network_security_group_association is true, network_security_group_id cannot be empty"
  }
}
