resource "azurerm_network_interface" "jump_win10" {
  name                = "jump-nic-win10"
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnetkubesubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.kubeiptf.id
  }
}

resource "azurerm_public_ip" "kubeiptf" {
  name                = "kube-public-ip"
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_windows_virtual_machine" "jumpvm" {
  name                = "jump-machine"
  resource_group_name = azurerm_resource_group.creatrg.name
  location            = azurerm_resource_group.creatrg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.jump_win10.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro"
    version   = "latest"
  }
}


