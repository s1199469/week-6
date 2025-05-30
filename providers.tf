terraform {
  required_version = ">= 0.13"
  required_providers {
    esxi = {
      source = "registry.terraform.io/josenk/esxi"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.31.0"      
    }
  }
}