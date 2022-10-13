variable "mandatory_tag_keys" {
  type        = list(any)
  description = "List of mandatory tag keys used by policies 'addTagToRG','inheritTagFromRG','bulkAddTagsToRG','bulkInheritTagsFromRG'"
  default = [
    "Application",
    "CostCenter",
    "Environment",
    "ManagedBy",
    "Owner",
    "Support"
  ]

}

variable "mandatory_tag_value" {
  type        = string
  description = "Tag value to include with the mandatory tag keys used by policies 'addTagToRG','inheritTagFromRG','bulkAddTagsToRG','bulkInheritTagsFromRG'"
  default     = "TBC"
}

variable "policy_definition_category" {
  type        = string
  description = "The category to use for all Policy Definitions"
  default     = "Custom"
}

variable "policy_definition_kubernetes_category" {
  type        = string
  description = "The category to use for all Policy Definitions"
  default     = "Kubernetes"
}

