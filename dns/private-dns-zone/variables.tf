variable "resource_group_name" {
  description = "Name of the resource group where the private dns zone will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the private dns zone"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "soa_record" {
  description = "Details of the soa record used for the private dns zone"
  type = object({
    email         = string
    host_name     = optional(string)
    expire_time   = optional(number, 2419200)
    minimum_ttl   = optional(number, 300)
    refresh_time  = optional(number, 3600)
    retry_time    = optional(number, 300)
    serial_number = optional(number, 1)
    ttl           = optional(number, 3600)
    tags          = optional(map(string))
  })
  default = null
}

variable "virtual_network_links" {
  description = "List of virtual network links to be added to the private dns zone"
  type = list(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
    resolution_policy    = optional(string)
  }))
  nullable = false
  default  = []
}

variable "a_records" {
  description = "List of a records to be added to the private dns zone"
  type = list(object({
    name    = string
    ttl     = number
    records = set(string)
  }))
  nullable = false
  default  = []
}

variable "aaaa_records" {
  description = "List of aaaa records to be added to the private dns zone"
  type = list(object({
    name    = string
    ttl     = number
    records = set(string)
  }))
  nullable = false
  default  = []
}

variable "cname_records" {
  description = "List of cname records to be added to the private dns zone"
  type = list(object({
    name   = string
    ttl    = number
    record = string
  }))
  nullable = false
  default  = []
}

variable "txt_records" {
  description = "List of txt records to be added to the private dns zone"
  type = list(object({
    name = string
    ttl  = number
    records = list(object({
      value = string
    }))
  }))
  nullable = false
  default  = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
