resource "azurerm_network_interface" "nic_vm1" {
  name                = "vm1-nic1"
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnetkubesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic_vm2" {
  name                = "vm2-nic2"
  location            = azurerm_resource_group.creatrg.location
  resource_group_name = azurerm_resource_group.creatrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnetkubesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm1" {
  name                  = "kube-vm1"
  location              = azurerm_resource_group.creatrg.location
  resource_group_name   = azurerm_resource_group.creatrg.name
  network_interface_ids = [azurerm_network_interface.nic_vm1.id]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "example_os_disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "kubevm1"
    admin_username = "adminuser"
    admin_password = "AdminPassword123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine" "vm2" {
  name                  = "kube-vm2"
  location              = azurerm_resource_group.creatrg.location
  resource_group_name   = azurerm_resource_group.creatrg.name
  network_interface_ids = [azurerm_network_interface.nic_vm2.id]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "example_os_disk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "kubevm2"
    admin_username = "adminuser"
    admin_password = "AdminPassword123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
