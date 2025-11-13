terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
resource "azurerm_private_endpoint" "main" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  subnet_id = var.subnet_id

  dynamic "private_service_connection" {
    for_each = var.private_service_connection != null ? ["enabled"] : []

    content {
      name                              = var.private_service_connection.name
      is_manual_connection              = var.private_service_connection.is_manual_connection
      private_connection_resource_id    = var.private_service_connection.private_connection_resource_id
      private_connection_resource_alias = var.private_service_connection.private_connection_resource_alias
      subresource_names                 = var.private_service_connection.subresource_names
      request_message                   = var.private_service_connection.request_message
    }
  }

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? ["enabled"] : []

    content {
      name                 = var.private_dns_zone_group.name
      private_dns_zone_ids = var.private_dns_zone_group.private_dns_zone_ids
    }
  }

  dynamic "ip_configuration" {
    for_each = { for config in var.ip_configurations : config.name => config }

    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association
resource "azurerm_private_endpoint_application_security_group_association" "example" {
  count = var.enable_application_security_group_association ? 1 : 0

  private_endpoint_id           = azurerm_private_endpoint.main.id
  application_security_group_id = var.application_security_group_id
}
