resource "azurerm_resource_group" "example2" {
  // take the substring from "/subscriptions/....../yicma-yicma-0-resources" to yicma-0-resources
  name     = substr(var.virtual_machine_id, -17, -1) 
  location = "East US"
}
