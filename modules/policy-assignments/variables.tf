data "azurerm_subscription" "current" {
}


variable "aks_policyset_id" {
  type        = string
  description = "The policy set definition id for aks"
}