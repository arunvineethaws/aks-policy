
output "aks_policyset_id" {
  value       = azurerm_policy_set_definition.aks.id
  description = "The policy set definition id for aks policy"
}

