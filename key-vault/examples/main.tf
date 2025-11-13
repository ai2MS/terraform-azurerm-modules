terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "example_basic" {
  source = "../../key-vault"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "kv-test"
}

module "example_complete" {
  source = "../../key-vault"

  location            = "centralus"
  resource_group_name = "rg-test"
  name                = "kv-test"

  sku_name                      = "standard"
  purge_protection_enabled      = true
  public_network_access_enabled = true
  soft_delete_retention_days    = 90

  network_acls = {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = ["175.157.41.138"]
    virtual_network_subnet_ids = ["snet-test"]
  }

  secrets = [
    {
      name            = "secret-test-01"
      value           = "secret-test-value-01"
      content_type    = "text/plain"
      not_before_date = "2025-07-20T00:00:00Z"
    },
    {
      name             = "secret-test-02"
      value_wo         = "secret-test-value-02"
      value_wo_version = 1
      content_type     = "text/plain"
      expiration_date  = "2025-12-31T23:59:59Z"
    }
  ]

  certificates = [
    {
      name = "certificate-test-01"

      certificate = {
        contents = "base-64-string"
        password = "PASSWORD"
      }
    },
    {
      name = "certificate-test-02"

      certificate_policy = {
        issuer_parameters = {
          name = "Self"
        }

        key_properties = {
          exportable = true
          key_size   = 2048
          key_type   = "RSA"
          reuse_key  = true
        }

        lifetime_action = {
          action = {
            action_type = "AutoRenew"
          }

          trigger = {
            days_before_expiry = 30
          }
        }

        secret_properties = {
          content_type = "application/x-pkcs12"
        }

        x509_certificate_properties = {
          # Server Authentication = 1.3.6.1.5.5.7.3.1
          # Client Authentication = 1.3.6.1.5.5.7.3.2
          extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

          key_usage = [
            "cRLSign",
            "dataEncipherment",
            "digitalSignature",
            "keyAgreement",
            "keyCertSign",
            "keyEncipherment",
          ]

          subject_alternative_names = {
            dns_names = ["internal.contoso.com", "domain.hello.world"]
            emails    = ["admin@contoso.com"]
            upns      = ["admin"]
          }

          subject            = "CN=hello-world"
          validity_in_months = 12
        }
      }
    }
  ]

  key_vault_administrator_principal_ids        = ["00000000-0000-0000-0000-000000000000"]
  key_vault_reader_principal_ids               = ["00000000-0000-0000-0000-000000000000"]
  key_vault_certificates_officer_principal_ids = ["00000000-0000-0000-0000-000000000000"]
  key_vault_certificate_user_principal_ids     = ["00000000-0000-0000-0000-000000000000"]
  key_vault_secrets_officer_principal_ids      = ["00000000-0000-0000-0000-000000000000"]
  key_vault_secrets_user_principal_ids         = ["00000000-0000-0000-0000-000000000000"]

  tags = {
    purpose = "example"
  }
}
