module "sqlvm" {
  source = "./sqlvm"

  count = var.vm_count

  vmname = "yicma-yicma-${count.index}"
}

module "joindomain" {

  source = "./joindomain"
  count  = var.vm_count

  virtual_machine_id = module.sqlvm[count.index].virtual_machine_id

// https://stackoverflow.com/questions/60276371/terraform-depends-on-resource-created-with-count
// all the module.sqlvm actually shares same name (can be found in the terraform.tfstate) so below is enough.
// And Terraform actually cannot depends on certain instance of the module with count, so below can actually be removed, virtual_machine_id depending on module.sqlvm[count.index] will let this module depends on all the instances of sqlvm module instead of just the [count.index] one (can be verified in the terraform.tfstate, that the dependencies doesn't have an index but only the module name)

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