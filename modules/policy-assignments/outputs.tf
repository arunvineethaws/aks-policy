
output "aks_assignment_id" {
  value       = azurerm_subscription_policy_assignment.aks.id
  description = "The policy assignment id for aks_prod"
}

output "aks_assignment_identity" {
  value       = azurerm_subscription_policy_assignment.aks.identity
  description = "The policy assignment identity for aks"
}