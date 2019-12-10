resource "azurerm_route_table" "aksRT" {
  name                = "${var.suffix}-routetable"
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name

  route {
    name                   = "default"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }

  tags = var.tags
}

resource "azurerm_virtual_network" "genericVNet" {
  name                = "${var.suffix}${var.vnetName}"
  location            = azurerm_resource_group.genericRG.location
  resource_group_name = azurerm_resource_group.genericRG.name
  address_space       = ["10.40.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.genericRG.name
  virtual_network_name = azurerm_virtual_network.genericVNet.name
  address_prefix       = "10.40.2.0/24"

  # work around for https://github.com/terraform-providers/terraform-provider-azurerm/issues/2358
  lifecycle {
    ignore_changes = [network_security_group_id, route_table_id]
  }
}

resource "azurerm_subnet" "public" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.genericRG.name
  virtual_network_name = azurerm_virtual_network.genericVNet.name
  address_prefix       = "10.40.4.0/24"

  # work around for https://github.com/terraform-providers/terraform-provider-azurerm/issues/2358
  lifecycle {
    ignore_changes = [network_security_group_id, route_table_id]
  }
}

resource "azurerm_subnet_route_table_association" "test" {
  subnet_id      = azurerm_subnet.internal.id
  route_table_id = azurerm_route_table.aksRT.id
}
