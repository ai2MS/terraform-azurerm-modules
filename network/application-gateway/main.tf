terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_gateway
resource "azurerm_application_gateway" "main" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = { for config in var.gateway_ip_configurations : config.name => config }

    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = { for port in var.frontend_ports : port.name => port }

    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = { for config in var.frontend_ip_configurations : config.name => config }

    content {
      name                            = frontend_ip_configuration.value.name
      subnet_id                       = frontend_ip_configuration.value.subnet_id
      private_ip_address              = frontend_ip_configuration.value.private_ip_address
      public_ip_address_id            = frontend_ip_configuration.value.public_ip_address_id
      private_ip_address_allocation   = frontend_ip_configuration.value.private_ip_address_allocation
      private_link_configuration_name = frontend_ip_configuration.value.private_link_configuration_name
    }
  }

  dynamic "backend_address_pool" {
    for_each = { for pool in var.backend_address_pools : pool.name => pool }

    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = { for settings in var.backend_http_settings : settings.name => settings }

    content {
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      name                                = backend_http_settings.value.name
      path                                = backend_http_settings.value.path
      port                                = backend_http_settings.value.port
      probe_name                          = backend_http_settings.value.probe_name
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      host_name                           = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names

      dynamic "authentication_certificate" {
        for_each = { for certificate in backend_http_settings.value.authentication_certificates : certificate.name => certificate }

        content {
          name = authentication_certificate.value.name
        }
      }

      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining != null ? ["enabled"] : []

        content {
          enabled           = backend_http_settings.value.connection_draining.enabled
          drain_timeout_sec = backend_http_settings.value.connection_draining.drain_timeout_sec
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = { for listener in var.http_listeners : listener.name => listener }

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      host_name                      = http_listener.value.host_name
      host_names                     = http_listener.value.host_names
      protocol                       = http_listener.value.protocol
      require_sni                    = http_listener.value.require_sni
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      firewall_policy_id             = http_listener.value.firewall_policy_id
      ssl_profile_name               = http_listener.value.ssl_profile_name

      dynamic "custom_error_configuration" {
        for_each = { for config in http_listener.value.custom_error_configurations : config.status_code => config }

        content {
          status_code           = custom_error_configuration.value.status_code
          custom_error_page_url = custom_error_configuration.value.custom_error_page_url
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = { for rule in var.request_routing_rules : rule.name => rule }

    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      redirect_configuration_name = request_routing_rule.value.redirect_configuration_name
      rewrite_rule_set_name       = request_routing_rule.value.rewrite_rule_set_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
      priority                    = request_routing_rule.value.priority
    }
  }

  dynamic "ssl_certificate" {
    for_each = nonsensitive(toset([for certificate in var.ssl_certificates : certificate.name]))

    content {
      name                = var.ssl_certificates[index(var.ssl_certificates.*.name, ssl_certificate.key)].name
      data                = var.ssl_certificates[index(var.ssl_certificates.*.name, ssl_certificate.key)].data
      password            = var.ssl_certificates[index(var.ssl_certificates.*.name, ssl_certificate.key)].password
      key_vault_secret_id = var.ssl_certificates[index(var.ssl_certificates.*.name, ssl_certificate.key)].key_vault_secret_id
    }
  }

  dynamic "probe" {
    for_each = { for probe in var.probes : probe.name => probe }

    content {
      host                                      = probe.value.host
      interval                                  = probe.value.interval
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      port                                      = probe.value.port
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      minimum_servers                           = probe.value.minimum_servers

      dynamic "match" {
        for_each = probe.value.match != null ? ["enabled"] : []

        content {
          body        = probe.value.match.body
          status_code = probe.value.match.status_code
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = { for config in var.redirect_configurations : config.name => config }

    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = redirect_configuration.value.target_listener_name
      target_url           = redirect_configuration.value.target_url
      include_path         = redirect_configuration.value.include_path
      include_query_string = redirect_configuration.value.include_query_string
    }
  }

  dynamic "private_link_configuration" {
    for_each = { for config in var.private_link_configurations : config.name => config }

    content {
      name = private_link_configuration.value.name

      dynamic "ip_configuration" {
        for_each = { for config in private_link_configuration.value.ip_configuration : config.name => config }

        content {
          name                          = ip_configuration.value.name
          subnet_id                     = ip_configuration.value.subnet_id
          private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
          primary                       = ip_configuration.value.primary
          private_ip_address            = ip_configuration.value.private_ip_address
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = { for config in var.custom_error_configurations : config.status_code => config }

    content {
      status_code           = custom_error_configuration.value.status_code
      custom_error_page_url = custom_error_configuration.value.custom_error_page_url
    }
  }

  enable_http2 = var.enable_http2

  dynamic "identity" {
    for_each = var.enable_identity ? ["enabled"] : []

    content {
      type = "SystemAssigned"
    }
  }

  tags = var.tags
}
