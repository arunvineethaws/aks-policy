variable "policyset_definition_kubernetes_category" {
  type        = string
  description = "The category to use for all PolicySet defintions"
  default     = "Kubernetes"
}


variable "custom_policies_aks" {
  type        = list(map(string))
  description = "List of custom policy definitions for the aks policyset"
  default     = []
}




variable "builtin_policies_aks" {
  type        = list(any)
  description = "List of policy definitions (display names) for the aks policyset"
  default = [
    "Azure Kubernetes Service Clusters should enable Azure Active Directory integration",
    "Azure Kubernetes Service Clusters should have local authentication methods disabled",
    "Azure Kubernetes Service Clusters should use managed identities",
    "Azure Kubernetes Service Private Clusters should be enabled",
    "Azure Policy Add-on for Kubernetes service (AKS) should be installed and enabled on your clusters",
    "Kubernetes cluster containers should not share host process ID or host IPC namespace",
    "Kubernetes cluster containers should only use allowed AppArmor profiles",
    "Kubernetes cluster containers should only use allowed seccomp profiles",
    "Kubernetes cluster containers should run with a read only root file system",
    "Kubernetes cluster pods should only use approved host network and port range",
    "Kubernetes cluster services should only use allowed external IPs",
    "Kubernetes cluster should not allow privileged containers",
    "Kubernetes cluster should not use naked pods",
    "Kubernetes clusters should be accessible only over HTTPS",
    "Kubernetes clusters should disable automounting API credentials",
    "Kubernetes clusters should not allow container privilege escalation",
    "Kubernetes clusters should not allow endpoint edit permissions of ClusterRole/system:aggregate-to-edit",
    "Kubernetes clusters should not grant CAP_SYS_ADMIN security capabilities",
    "Kubernetes clusters should not use specific security capabilities",
    "Kubernetes clusters should not use the default namespace",
    "Kubernetes Services should be upgraded to a non-vulnerable Kubernetes version",
    "Resource logs in Azure Kubernetes Service should be enabled",
    "Role-Based Access Control (RBAC) should be used on Kubernetes Services",
    "Temp disks and cache for agent node pools in Azure Kubernetes Service clusters should be encrypted at host"
  ]
}


data "azurerm_policy_definition" "builtin_policies_aks" {
  count        = length(var.builtin_policies_aks)
  display_name = var.builtin_policies_aks[count.index]
}
