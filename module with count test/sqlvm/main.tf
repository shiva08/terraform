resource "azurerm_resource_group" "example2" {
  name     = "${var.vmname}-resources"
  location = "North Europe"
}
