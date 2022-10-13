
output "AKSDefenderProfile_policy_id" {
  value       = azurerm_policy_definition.AKSDefenderProfile.id
  description = "The policy definition id for AKSDefenderProfile"
}

output "AllowedPorts_policy_id" {
  value       = azurerm_policy_definition.AllowedPorts.id
  description = "The policy definition id for AKS Allowed Ports"
  
}

output "AKSDisablecmdinvoke_policy_id" {
  value       = azurerm_policy_definition.AKSDisablecmdinvoke.id
  description = "The policy definition id for AKS disable command invoke"
  
}
