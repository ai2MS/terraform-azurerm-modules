variable "location" {
  description = "Azure region where the private endpoint will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the private endpoint will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the private endpoint"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "subnet_id" {
  description = "The id of the subnet from which private ip addresses will be allocated for this private endpoint"
  type        = string
  nullable    = false
}

variable "private_service_connection" {
  description = "The private service connection to be used for this private endpoint"
  type = object({
    name                              = string
    is_manual_connection              = bool
    private_connection_resource_id    = optional(string)
    private_connection_resource_alias = optional(string)
    subresource_names                 = optional(set(string))
    request_message                   = optional(string)
  })
  nullable = true
  default  = null
}

variable "private_dns_zone_group" {
  description = "The private dns zone group to be used for this private endpoint"
  type = object({
    name                 = string
    private_dns_zone_ids = set(string)
  })
  nullable = true
  default  = null
}

variable "ip_configurations" {
  description = "This allows a static ip address to be set for this private endpoint, otherwise an address is dynamically allocated from the subnet"
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  nullable = false
  default  = []
}

variable "enable_application_security_group_association" {
  description = "Enable the subnet to be associated with an application security group"
  type        = bool
  nullable    = false
  default     = false
}

variable "application_security_group_id" {
  description = "Id of the application security group to associate with the subnet"
  type        = string
  nullable    = false
  default     = ""

  validation {
    condition     = var.enable_application_security_group_association ? (length(var.application_security_group_id) > 0) : true
    error_message = "if enable_application_security_group_association is true, application_security_group_id cannot be empty"
  }
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
