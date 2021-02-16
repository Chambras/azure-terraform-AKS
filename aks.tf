resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.k8sVersion

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name                = "default"
    node_count          = var.agent_count
    vm_size             = "Standard_DS2_v2"
    os_disk_size_gb     = 30
    enable_auto_scaling = "true"
    type                = "VirtualMachineScaleSets"
    min_count           = 2
    max_count           = 3

    # Required for advanced networking
    vnet_subnet_id = azurerm_subnet.internal.id
  }

  /*service_principal {
    client_id     = var.kubernetes_client_id
    client_secret = var.kubernetes_client_secret
  }
*/
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin = "azure"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled = false
    }
  }
  # If you're using AutoScaling, you may wish to use Terraform's ignore_changes functionality to ignore changes to the node_count field.
  lifecycle {
    ignore_changes = [default_node_pool["node_count"]]
  }

  tags = var.tags
}
