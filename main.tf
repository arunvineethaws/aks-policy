terraform {
  
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "policy_assignments" {
  source = "./modules/policy-assignments"
  aks_policyset_id                        = module.policyset_definitions.aks_policyset_id
}

module "policy_definitions" {
  source = "./modules/policy-definitions"

}

module "policyset_definitions" {
  source = "./modules/policyset-definitions"


  custom_policies_aks = [
    {
      policyID = module.policy_definitions.AKSDefenderProfile_policy_id
    },
    {
      policyID = module.policy_definitions.AllowedPorts_policy_id
    },
    {
      policyID = module.policy_definitions.AKSDisablecmdinvoke_policy_id
    }
  ]

}