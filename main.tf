resource "random_pet" "rg-name" {
  prefix    = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  count     = var.vm_count
  name      = "${random_pet.rg-name.id}-${count.index}"
  location  = var.resource_group_location
}
