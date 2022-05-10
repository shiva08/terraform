resource "azurerm_virtual_machine_extension" "domjoin" {
    name = "domjoin"
    virtual_machine_id = var.virtual_machine_id



    //virtual_machine_id = "${element(azurerm_virtual_machine.example2.*.id, count.index )}"

    //virtual_machine_id = sqlvm.azurerm_virtual_machine.example2.*.id

    publisher = "Microsoft.Compute"
    type = "JsonADDomainExtension"
    type_handler_version = "1.3"

    settings = <<SETTINGS
        {
        "Name": var.domain_name,
        "OUPath": var.oupath,
        "User": var.domain_join_username,
        "Restart": "true",
        "Options": "3"
        }

    SETTINGS
    protected_settings = <<PROTECTED_SETTINGS
      {
      "Password": var.domain_join_password
      }
    PROTECTED_SETTINGS
}