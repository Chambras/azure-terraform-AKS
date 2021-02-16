variable "releaseName" {
  type        = string
  default     = "nginx-ingress-controller"
  description = " Release name."
}

variable "namespace" {
  type        = string
  default     = "helmnginx"
  description = "The namespace to install the release into."
}

variable "charRepo" {
  type        = string
  default     = "https://charts.bitnami.com/bitnami"
  description = "Repository URL where to locate the requested chart."
}

variable "chartName" {
  type        = string
  default     = "nginx-ingress-controller"
  description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified. It is also possible to use the <repository>/<chart> format here if you are running Terraform on a system that the repository has been added to with helm repo add but this is not recommended."

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
