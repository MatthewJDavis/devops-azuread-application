terraform {
  backend "azurerm" {
  }
}

provider "azuread" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider to be used
  version = "=1.5.0"
}

variable "app_password" {  
  description = "Used for application secret"  
  type        = string  
  sensitive   = true
}

variable "application_name" {
  type = string
}

variable "homepage" {
  type = string
}

variable "identifier_uris" {
  type = list
}

variable "reply_urls" {
  type = list
}

resource "azuread_application" "directory_role_app" {
  display_name = var.application_name
  homepage                   = var.homepage
  identifier_uris            = var.identifier_uris
  reply_urls                 = var.reply_urls
  available_to_other_tenants = false

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }

}

resource "azuread_application_password" "demo" {
  application_object_id = azuread_application.directory_role_app.object_id
  value = var.app_password
  display_name = "MG Graph Directory Role App cred"
}

resource "azuread_service_principal" "dra_sp" {
  application_id               = azuread_application.directory_role_app.application_id
  app_role_assignment_required = false

  tags = ["example", "tags", "here"]
}

resource "azuread_service_principal_password" "dra_pw" {
  service_principal_id = azuread_service_principal.dra_sp.object_id
}