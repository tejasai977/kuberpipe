resource "azurerm_network_security_group" "nsgkube" {
  name                = "kube-nsg"
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_rdp"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "attachnsgkube" {
  subnet_id                 = azurerm_subnet.vnetkubesubnet.id
  network_security_group_id = azurerm_network_security_group.nsgkube.id
}
