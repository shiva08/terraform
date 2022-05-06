module "sqlvm" {

  source = "./sqlvm"
  count  = var.vm_count              #reserved key words , won't be passed as arguents to child templates

  resource_group_name_prefix = var.resource_group_name_prefix
  resource_group_location    = var.resource_group_location

  vm_suffix = count.index


}

