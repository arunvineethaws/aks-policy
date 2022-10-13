resource "azurerm_policy_set_definition" "aks" {

  name         = "aks"
  policy_type  = "Custom"
  display_name = "AKS Set"
  description  = "Contains AKS policies"

  metadata = jsonencode(
    {
      "category" : "${var.policyset_definition_kubernetes_category}"
    }

  )

  dynamic "policy_definition_reference" {
    for_each = var.custom_policies_aks
    content {
      policy_definition_id = policy_definition_reference.value["policyID"]
      reference_id         = policy_definition_reference.value["policyID"]
    }
  }

  dynamic "policy_definition_reference" {
    for_each = data.azurerm_policy_definition.builtin_policies_aks
    content {
      policy_definition_id = policy_definition_reference.value["id"]
      reference_id         = policy_definition_reference.value["display_name"]
    }
  }
}