resource "azurerm_virtual_machine_extension" "domjoin" {
    name = "domjoin"
    virtual_machine_id = var.virtual_machine_id

    publisher = "Microsoft.Compute"
    type = "JsonADDomainExtension"
    type_handler_version = "1.3"

    settings = <<SETTINGS
        {
        "Name": "${var.domain_name}",
        "OUPath": "${var.oupath}",
        "User":  "${split(".", var.domain_name)[0]}\\${var.domain_join_username}",
        "Restart": "true",
        "Options": "3"
        }

    SETTINGS
    protected_settings = <<PROTECTED_SETTINGS
      {
      "Password": "${var.domain_join_password}"
      }
    PROTECTED_SETTINGS
}