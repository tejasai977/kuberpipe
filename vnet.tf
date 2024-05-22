resource "azurerm_virtual_network" "vnetkube" {
  name                = "kube-vnet"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name
}

resource "azurerm_subnet" "vnetkubesubnet" {
  name                 = "kube-subnet"
  resource_group_name  = azurerm_resource_group.creatrg.name
  virtual_network_name = azurerm_virtual_network.vnetkube.name
  address_prefixes     = ["10.0.0.0/25"]
}