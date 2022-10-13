
resource "azurerm_subscription_policy_assignment" "aks" {
  name                 = "aks"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = var.aks_policyset_id
  description          = "Assignment of the aks initiative to subscription."
  display_name         = "AKS Set"
  location             = "australiaeast"
  identity { type = "SystemAssigned" }
}