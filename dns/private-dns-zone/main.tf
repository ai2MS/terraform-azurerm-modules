terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
resource "azurerm_private_dns_zone" "main" {
  resource_group_name = var.resource_group_name
  name                = var.name

  dynamic "soa_record" {
    for_each = var.soa_record != null ? ["enabled"] : []

    content {
      email         = var.soa_record.email
      host_name     = var.soa_record.host_name
      expire_time   = var.soa_record.expire_time
      minimum_ttl   = var.soa_record.minimum_ttl
      refresh_time  = var.soa_record.refresh_time
      retry_time    = var.soa_record.retry_time
      serial_number = var.soa_record.serial_number
      ttl           = var.soa_record.ttl
      tags          = var.soa_record.tags
    }
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  for_each = { for virtual_network_link in var.virtual_network_links : virtual_network_link.name => virtual_network_link }

  private_dns_zone_name = azurerm_private_dns_zone.main.name

  resource_group_name = var.resource_group_name

  name                 = each.value.name
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  resolution_policy    = each.value.resolution_policy

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record
resource "azurerm_private_dns_a_record" "main" {
  for_each = { for a_record in var.a_records : a_record.name => a_record }

  zone_name = azurerm_private_dns_zone.main.name

  resource_group_name = var.resource_group_name
  name                = each.value.name

  ttl     = each.value.ttl
  records = each.value.records

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record
resource "azurerm_private_dns_aaaa_record" "main" {
  for_each = { for aaaa_record in var.aaaa_records : aaaa_record.name => aaaa_record }

  zone_name = azurerm_private_dns_zone.main.name

  resource_group_name = var.resource_group_name
  name                = each.value.name

  ttl     = each.value.ttl
  records = each.value.records

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record
resource "azurerm_private_dns_cname_record" "main" {
  for_each = { for cname_record in var.cname_records : cname_record.name => cname_record }

  zone_name = azurerm_private_dns_zone.main.name

  resource_group_name = var.resource_group_name
  name                = each.value.name

  ttl    = each.value.ttl
  record = each.value.record

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record
resource "azurerm_private_dns_txt_record" "main" {
  for_each = { for txt_record in var.txt_records : txt_record.name => txt_record }

  zone_name = azurerm_private_dns_zone.main.name

  resource_group_name = var.resource_group_name
  name                = each.value.name

  ttl = each.value.ttl

  dynamic "record" {
    for_each = { for record in each.value.records : record.value => record }

    content {
      value = record.value.value
    }
  }

  tags = var.tags
}
