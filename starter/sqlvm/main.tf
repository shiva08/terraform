resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name      = "${random_pet.rg-name.id}-${var.vm_suffix}"
  location  = var.resource_group_location
}
