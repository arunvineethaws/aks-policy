resource "azurerm_policy_definition" "AllowedPorts" {
  name         = "AllowedPorts"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Kubernetes cluster services should listen only on allowed ports"
  description  = "Restrict services to listen only on allowed ports to secure access to the Kubernetes cluster. This policy is generally available for Kubernetes Service (AKS), and preview for Azure Arc enabled Kubernetes. For more information, see https://aka.ms/kubepolicydoc."

  metadata = jsonencode(
    {
      "category" : "${var.policy_definition_kubernetes_category}",
      "version" : "8.0.0"
    }
  )
  policy_rule = jsonencode(
    {
      "if": {
        "field": "type",
        "in": [
          "Microsoft.Kubernetes/connectedClusters",
          "Microsoft.ContainerService/managedClusters"
        ]
      },
      "then": {
        "effect": "[parameters('effect')]",
        "details": {
          "templateInfo": {
            "sourceType": "PublicURL",
            "url": "https://store.policy.core.windows.net/kubernetes/service-allowed-ports/v1/template.yaml"
          },
          "apiGroups": [
            ""
          ],
          "kinds": [
            "Service"
          ],
          "excludedNamespaces": "[parameters('excludedNamespaces')]",
          "namespaces": "[parameters('namespaces')]",
          "labelSelector": "[parameters('labelSelector')]",
          "values": {
            "allowedServicePorts": "[parameters('allowedServicePortsList')]",
            "allowedPorts": "[parameters('allowedServicePortsList')]"
          }
        }
      }
    }
  )
  parameters = jsonencode(
    {
      "effect": {
        "type": "String",
        "metadata": {
          "displayName": "Effect",
          "description": "'Audit' allows a non-compliant resource to be created, but flags it as non-compliant. 'Deny' blocks the resource creation. 'Disable' turns off the policy."
        },
        "allowedValues": [
          "audit",
          "Audit",
          "deny",
          "Deny",
          "disabled",
          "Disabled"
        ],
        "defaultValue": "Deny"
      },
      "excludedNamespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace exclusions",
          "description": "List of Kubernetes namespaces to exclude from policy evaluation. System namespaces \"kube-system\", \"gatekeeper-system\" and \"azure-arc\" are always excluded by design."
        },
        "defaultValue": [
          "kube-system",
          "gatekeeper-system",
          "azure-arc"
        ]
      },
      "namespaces": {
        "type": "Array",
        "metadata": {
          "displayName": "Namespace inclusions",
          "description": "List of Kubernetes namespaces to only include in policy evaluation. An empty list means the policy is applied to all resources in all namespaces."
        },
        "defaultValue": []
      },
      "labelSelector": {
        "type": "Object",
        "metadata": {
          "displayName": "Kubernetes label selector",
          "description": "Label query to select Kubernetes resources for policy evaluation. An empty label selector matches all Kubernetes resources."
        },
        "defaultValue": {},
        "schema": {
          "description": "A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all resources.",
          "type": "object",
          "properties": {
            "matchLabels": {
              "description": "matchLabels is a map of {key,value} pairs.",
              "type": "object",
              "additionalProperties": {
                "type": "string"
              },
              "minProperties": 1
            },
            "matchExpressions": {
              "description": "matchExpressions is a list of values, a key, and an operator.",
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "key": {
                    "description": "key is the label key that the selector applies to.",
                    "type": "string"
                  },
                  "operator": {
                    "description": "operator represents a key's relationship to a set of values.",
                    "type": "string",
                    "enum": [
                      "In",
                      "NotIn",
                      "Exists",
                      "DoesNotExist"
                    ]
                  },
                  "values": {
                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty.",
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  }
                },
                "required": [
                  "key",
                  "operator"
                ],
                "additionalProperties": false
              },
              "minItems": 1
            }
          },
          "additionalProperties": false
        }
      },
      "allowedServicePortsList": {
        "type": "Array",
        "metadata": {
          "displayName": "Allowed service ports list",
          "description": "The list of service ports allowed in a Kubernetes cluster. Array only accepts strings. Example: [\"443\", \"80\"]"
        },
        "defaultValue": ["443", "80"]
      }
    }
  )
}