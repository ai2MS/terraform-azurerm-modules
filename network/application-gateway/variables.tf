variable "location" {
  description = "Azure region where the application gateway will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the application gateway will be created"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty"
  }
}

variable "name" {
  description = "Name of the application gateway"
  type        = string
  nullable    = false

  validation {
    condition     = length(var.name) > 0
    error_message = "name cannot be empty"
  }
}

variable "sku" {
  description = "SKU of the application gateway"
  type = object({
    name     = string
    tier     = string
    capacity = optional(string)
  })
  nullable = false
}

variable "gateway_ip_configurations" {
  description = "Gateway ip configurations of the application gateway"
  type = list(object({
    name      = string
    subnet_id = string
  }))
  nullable = false
  default  = []
}

variable "frontend_ports" {
  description = "Frontend ports of the application gateway"
  type = list(object({
    name = string
    port = number
  }))
  nullable = false
  default  = []
}

variable "frontend_ip_configurations" {
  description = "Frontend ip configurations of the application gateway"
  type = list(object({
    name                            = string
    subnet_id                       = optional(string)
    private_ip_address              = optional(string)
    public_ip_address_id            = optional(string)
    private_ip_address_allocation   = optional(string, "Dynamic")
    private_link_configuration_name = optional(string)
  }))
  nullable = false
  default  = []
}

variable "backend_address_pools" {
  description = "Backend address pools of the application gateway"
  type = list(object({
    name         = string
    fqdns        = optional(set(string))
    ip_addresses = optional(set(string))
  }))
  nullable = false
  default  = []
}

variable "backend_http_settings" {
  description = "Backend http settings of the application gateway"
  type = list(object({
    cookie_based_affinity               = optional(string)
    affinity_cookie_name                = optional(string)
    name                                = string
    path                                = optional(string)
    port                                = number
    probe_name                          = optional(string)
    protocol                            = string
    request_timeout                     = optional(number, 30)
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool, false)
    trusted_root_certificate_names      = optional(set(string))

    authentication_certificates = optional(list(object({
      name = string
    })), [])

    connection_draining = optional(object({
      enabled           = bool
      drain_timeout_sec = optional(number)
    }))
  }))
  nullable = false
  default  = []
}

variable "http_listeners" {
  description = "HTTP listeners of the application gateway"
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    host_name                      = optional(string)
    host_names                     = optional(set(string))
    protocol                       = string
    require_sni                    = optional(bool, false)
    ssl_certificate_name           = optional(string)
    firewall_policy_id             = optional(string)
    ssl_profile_name               = optional(string)

    custom_error_configurations = optional(list(object({
      status_code           = string
      custom_error_page_url = string
    })), [])
  }))
  nullable = false
  default  = []
}

variable "request_routing_rules" {
  description = "Request routing rules of the application gateway"
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    url_path_map_name           = optional(string)
    priority                    = optional(number)
  }))
  nullable = false
  default  = []
}

variable "ssl_certificates" {
  description = "SSL certificates used by the application gateway"
  type = list(object({
    name                = string
    data                = optional(string)
    password            = optional(string)
    key_vault_secret_id = optional(string)
  }))
  sensitive = true
  nullable  = false
  default   = []
}

variable "probes" {
  description = "Probes used by the application gateway"
  type = list(object({
    host                                      = optional(string)
    interval                                  = number
    name                                      = string
    protocol                                  = string
    path                                      = string
    timeout                                   = number
    unhealthy_threshold                       = number
    port                                      = optional(number)
    pick_host_name_from_backend_http_settings = optional(bool, false)
    minimum_servers                           = optional(number, 0)

    match = optional(object({
      body        = string
      status_code = list(number)
    }))
  }))
  nullable = false
  default  = []
}

variable "redirect_configurations" {
  description = "Redirect configurations used by the application gateway"
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = optional(string)
    target_url           = optional(string)
    include_path         = optional(bool, false)
    include_query_string = optional(bool, false)
  }))
  nullable = false
  default  = []
}

variable "custom_error_configurations" {
  description = "Custom error configurations used by the application gateway"
  type = list(object({
    status_code           = string
    custom_error_page_url = string
  }))
  nullable = false
  default  = []
}

variable "private_link_configurations" {
  description = "Private link configurations used by the application gateway"
  type = list(object({
    name = string
    ip_configuration = list(object({
      name                          = string
      subnet_id                     = string
      private_ip_address_allocation = string
      primary                       = bool
      private_ip_address            = optional(string)
    }))
  }))
  nullable = false
  default  = []
}

variable "enable_http2" {
  description = "Determines whether http2 is enabled on the application gateway"
  type        = bool
  nullable    = false
  default     = false
}

variable "enable_identity" {
  description = "Determines whether managed identity is enabled on the application gateway"
  type        = bool
  nullable    = false
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resources"
  type        = map(string)
  default     = null
}
