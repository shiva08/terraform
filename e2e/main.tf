module "sqlvm" {
  source = "./sqlvm"

  count = var.vm_count

  vmname = "shiva-${count.index}"

  rgname   = var.rgname
  location = var.location
  vnetname = var.vnetname
  subnet   = var.subnet
  localadmin_username = var.localadmin_username
  localadmin_password = var.localadmin_password


}