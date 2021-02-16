variable "namespace" {
  type        = string
  default     = "nginx"
  description = "The namespace to use."
}

variable "AKSRGName" {
  type        = string
  default     = "MZVmainAKS"
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster exists."
}

variable "AKSClusterName" {
  type        = string
  default     = "mainAKSCluster"
  description = "The name of the Managed Kubernetes Cluster to use."
}
