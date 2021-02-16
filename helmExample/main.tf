terraform {
  # It is recommended to use remote state instead of local
  # You can update these values in order to configure your remote state.
  /*  backend "remote" {
    organization = "{{ORGANIZATION_NAME}}"

    workspaces {
      name = "{{WORKSPACE_NAME}}"
    }
  }
*/
  required_version = "= 0.14.6"

  required_providers {
    kubernetes = ">= 2.0.2"
    helm       = "=2.0.2"
    azurerm    = "=2.47.0"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/aksconfig"
  }
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.k8s.kube_config.0.host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

provider "azurerm" {
  features {}
}

data "azurerm_kubernetes_cluster" "k8s" {
  name                = var.AKSClusterName
  resource_group_name = var.AKSRGName
}


resource "kubernetes_namespace" "nginx" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name      = var.releaseName
  namespace = var.namespace

  repository = var.charRepo
  chart      = var.chartName

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}
