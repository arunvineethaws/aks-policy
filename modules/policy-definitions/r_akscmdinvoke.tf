resource "azurerm_policy_definition" "AKSDisablecmdinvoke" {
  name         = "AKSDisablecmdinvoke"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Azure Kubernetes Service Clusters should disable Command Invoke"
  description  = "Disabling command invoke can enhance the security by avoiding bypass of restricted network access or Kubernetes role-based access control"

  metadata = jsonencode(
    {
      "category" : "${var.policy_definition_kubernetes_category}",
      "version" : "1.0.0"
    }
  )
  policy_rule = jsonencode(
    {
      "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.ContainerService/managedClusters"
          },
          {
            "field": "Microsoft.ContainerService/managedClusters/apiServerAccessProfile.disableRunCommand",
            "notEquals": true
          }
        ]
      },
      "then": {
        "effect": "[parameters('effect')]"
      }
    }
  )
  parameters = jsonencode(
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "Enable or disable the execution of the policy."
        },
        "allowedValues": [
          "Audit",
          "Disabled"
        ],
        "defaultValue": "Audit"
      }
    }
  )
}


