resource "azurerm_policy_definition" "AKSDefenderProfile" {
  name         = "AKSDefenderProfile"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Azure Kubernetes Service clusters should have Defender profile enabled"
  description  = "Microsoft Defender for Containers provides cloud-native Kubernetes security capabilities including environment hardening, workload protection, and run-time protection. When you enable the SecurityProfile.AzureDefender on your Azure Kubernetes Service cluster, an agent is deployed to your cluster to collect security event data. Learn more about Microsoft Defender for Containers in https://docs.microsoft.com/azure/defender-for-cloud/defender-for-containers-introduction?tabs=defender-for-container-arch-aks"

  metadata = jsonencode(
    {
      "category" : "${var.policy_definition_kubernetes_category}",
      "version" : "2.0.0"
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
            "field": "Microsoft.ContainerService/managedClusters/securityProfile.defender.securityMonitoring.enabled",
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
          "description": "Enable or disable the execution of the policy"
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


