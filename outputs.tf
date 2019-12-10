output "rgName" {
  value = "${azurerm_resource_group.genericRG.name}"
}

## Cluster Details
output "kube_config" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
}
