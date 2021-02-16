variable "location" {
  type        = string
  default     = "eastus2"
  description = "Location where the resoruces are going to be created."
}

variable "suffix" {
  default = "MZV"
}

variable "tags" {
  type = map(any)
  default = {
    "Environment" = "Dev"
    "Project"     = "Demo"
    "BillingCode" = "Internal"
    "Customer"    = "USRI"
  }
}

variable "rgName" {
  type        = string
  default     = "AKSRG"
  description = "Resource Group Name."
}

variable "ssh_public_key" {
  type        = string
  default     = "~/.ssh/vm_ssh.pub"
  description = "The Path at which your Public SSH Key is located. Defaults to ~/.ssh/vm_ssh.pub"
  sensitive   = true
}

## AKS variables
variable "cluster_name" {
  type        = string
  default     = "mainAKSCluster"
  description = "Main AKS Cluster"
}

variable "k8sVersion" {
  type        = string
  default     = "1.18.14"
  description = "Kubernetes version to use."

}

variable "dns_prefix" {
  type        = string
  default     = "mainAKSCluster"
  description = "DNS prefix specified when creating the managed cluster."
}

variable "agent_count" {
  type        = number
  default     = 2
  description = "Number of Agents (VMs) in the Pool. Possible values must be in the range of 1 to 100 (inclusive)."
}

variable "kubernetes_client_id" {
  type        = string
  default     = ""
  description = "The Client ID for the Service Principal to use for this Managed Kubernetes Cluster"
}

variable "kubernetes_client_secret" {
  type        = string
  default     = ""
  description = "The Client Secret for the Service Principal to use for this Managed Kubernetes Cluster"
}

## Networking variables
variable "vnetName" {
  type        = string
  default     = "AKSVNet"
  description = "VNet name."
}

## Security variables
variable "sgName" {
  type        = string
  default     = "default_RDPSSH_SG"
  description = "Default Security Group Name to be applied by default to VMs and subnets."
}

variable "sourceIPs" {
  type        = list(any)
  default     = ["173.66.216.193"]
  description = "Public IPs to allow inboud communications."
}
