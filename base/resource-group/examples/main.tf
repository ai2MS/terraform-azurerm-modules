terraform {
	required_version = "~> 1.0"

	required_providers {
		azurerm = {
			source  = "hashicorp/azurerm"
			version = "~> 4.40.0"
		}
	}
}

module "example_basic" {
  source = "../../resource-group"

  location = "centralus"
  name     = "rg-test"
}

module "example_complete" {
  source = "../../resource-group"

  location = "centralus"
  name     = "rg-test"

  tags = {
    purpose = "example"
  }
}
