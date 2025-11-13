terraform {
	required_version = "~> 1.0"

	required_providers {
		azurerm = {
			source  = "hashicorp/azurerm"
			version = "~> 4.40.0"
		}
	}
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "main" {
  location = var.location
  name     = var.name

  tags = var.tags
}
