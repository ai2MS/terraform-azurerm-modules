output "id" {
  description = "The id of the private dns zone"
  value       = azurerm_private_dns_zone.main.id
}

output "name" {
  description = "The name of the private dns zone"
  value       = azurerm_private_dns_zone.main.name
}

output "resource_group_name" {
  description = "The name of the resource group the private dns zone is in"
  value       = azurerm_private_dns_zone.main.resource_group_name
}

output "number_of_record_sets" {
  description = " The number of records already in the zone"
  value       = azurerm_private_dns_zone.main.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "Maximum number of records in the private dns zone"
  value       = azurerm_private_dns_zone.main.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  description = "The maximum number of virtual networks that can be linked to this private dns zone"
  value       = azurerm_private_dns_zone.main.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  description = "The maximum number of virtual networks that can be linked to this private dns zone with registration enabled"
  value       = azurerm_private_dns_zone.main.max_number_of_virtual_network_links_with_registration
}

output "a_records" {
  description = "A list of a records in the private dns zone"
  value = [for record in azurerm_private_dns_a_record.main : {
    id   = record.id
    fqdn = record.fqdn
  }]
}

output "aaaa_records" {
  description = "A list of aaaa records in the private dns zone"
  value = [for record in azurerm_private_dns_aaaa_record.main : {
    id   = record.id
    fqdn = record.fqdn
  }]
}

output "cname_records" {
  description = "A list of cname records in the private dns zone"
  value = [for record in azurerm_private_dns_cname_record.main : {
    id   = record.id
    fqdn = record.fqdn
  }]
}

output "txt_records" {
  description = "A list of txt records in the private dns zone"
  value = [for record in azurerm_private_dns_txt_record.main : {
    id   = record.id
    fqdn = record.fqdn
  }]
}
