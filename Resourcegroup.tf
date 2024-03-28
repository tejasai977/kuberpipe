resource "azurerm_resource_group" "creatrg" {
  name     = var.rgname
  location = var.rglocation
}