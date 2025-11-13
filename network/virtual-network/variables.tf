variable "location" {
  description = "Azure region where the virtual network will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the virtual network will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the virtual network"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = set(string)
  default     = null
}

variable "dns_servers" {
  description = "List of DNS servers to use for the virtual network"
  type        = set(string)
  default     = null
}

variable "private_endpoint_vnet_policies" {
  description = "List of DNS servers to use for the virtual network"
  type        = string
  nullable    = false
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Basic"], var.private_endpoint_vnet_policies)
    error_message = "invalid private_endpoint_vnet_policies value"
  }
}

variable "peerings" {
  description = "List of peering configurations to be connected to the virtual network"
  type = list(object({
    name                                   = string
    remote_virtual_network_id              = string
    allow_virtual_network_access           = optional(bool, true)
    allow_forwarded_traffic                = optional(bool, false)
    allow_gateway_transit                  = optional(bool, false)
    local_subnet_names                     = optional(set(string))
    only_ipv6_peering_enabled              = optional(bool)
    peer_complete_virtual_networks_enabled = optional(bool, true)
    remote_subnet_names                    = optional(set(string))
    use_remote_gateways                    = optional(bool, false)
  }))
  nullable = false
  default  = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
