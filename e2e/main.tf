module "sqlvm" {
  source = "./sqlvm"

  count = var.vm_count

  vmname = "terraform-${count.index}"

  rgname              = var.rgname
  location            = var.location
  vnetname            = var.vnetname
  subnet              = var.subnet
  localadmin_username = var.localadmin_username
  localadmin_password = var.localadmin_password


}

module "joindomain" {

  source = "./joindomain"
  count  = var.vm_count

  //virtual_machine_id = sqlvm.azurerm_virtual_machine.example2.*.id

//  virtual_machine_id = "${element(sqlvm.azurerm_virtual_machine.example2.*.id, count.index )}"

  virtual_machine_id = module.sqlvm[count.index].virtual_machine_id


  domain_name          = var.domain_name
  oupath               = var.oupath
  domain_join_username = var.domain_join_username
  domain_join_password = var.domain_join_password

  depends_on = [
    module.sqlvm.virtual_machine_id,
  ]
}


/*
make parallel deployments

extension code correct?

depends on another module

access vm id in another batch for joindomain

*/