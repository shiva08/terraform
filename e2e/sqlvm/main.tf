/*
resource "azurerm_resource_group" "example2" {
  name     = "${var.vmname}-resources"
  location = var.location
}
*/

resource "azurerm_network_security_group" "example2" {
  name                = "${var.vmname}-NSG"
  location            = var.location
  resource_group_name = var.rgname
  security_rule {
    name                       = "RDPBlock"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

/*
resource "azurerm_virtual_network" "example2" {
  name                = "${var.vmname}-VN"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rgname
  
  tags = {
    environment = "global"
  }

  subnet {
	  name                 = "${var.vmname}-SN"
	  address_prefix     = "10.0.0.0/24"
	  security_group = azurerm_network_security_group.example2.id
  }
}
*/

/*
resource "azurerm_public_ip" "vm2" {
  name                = "${var.vmname}-PIP"
  location            = var.location
  resource_group_name = var.rgname
  allocation_method   = "Dynamic"
}
*/

/*resource "azurerm_network_security_rule" "RDPRule" {
  name                        = "RDPRule"
  resource_group_name         = var.rgname
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 3389
  source_address_prefix       = "167.220.255.0/25"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example2.name
}

resource "azurerm_network_security_rule" "MSSQLRule" {
  name                        = "MSSQLRule"
  resource_group_name         = azurerm_resource_group.example2.name
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = 1433
  source_address_prefix       = "167.220.255.0/25"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example2.name
}*/

resource "azurerm_network_interface" "example2" {
  name                = "${var.vmname}-NIC"
  location            = var.location
  resource_group_name = var.rgname
  #network_security_group_id = azurerm_network_security_group.example2.id

  ip_configuration {
    name      = "example2configuration1"
    subnet_id = "/subscriptions/0009fc4d-e310-4e40-8e63-c48a23e9cdc1/resourceGroups/${var.rgname}/providers/Microsoft.Network/virtualNetworks/${var.vnetname}/subnets/${var.subnet}"

    #azurerm_virtual_network.example2.subnet.*.id[0]

    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.vm2.id
  }
}

resource "azurerm_network_interface_security_group_association" "example2" {
  network_interface_id      = azurerm_network_interface.example2.id
  network_security_group_id = azurerm_network_security_group.example2.id
}

resource "azurerm_virtual_machine" "example2" {
  name                  = "${var.vmname}-VM"
  location              = var.location
  resource_group_name   = var.rgname
  network_interface_ids = [azurerm_network_interface.example2.id]
  vm_size               = "Standard_DS14_v2"

  storage_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "SQL2017-WS2016"
    sku       = "SQLDEV"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vmname}-OSDisk"
    caching           = "ReadOnly"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "winhost01"
    admin_username = "{var.localadmin_username}"
    admin_password = "{var.localadmin_password}"
  }

  os_profile_windows_config {
    timezone                  = "Pacific Standard Time"
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }
}

resource "azurerm_mssql_virtual_machine" "example2" {
  virtual_machine_id               = azurerm_virtual_machine.example2.id
  sql_license_type                 = "PAYG"
  r_services_enabled               = true
  sql_connectivity_port            = 1433
  sql_connectivity_type            = "PRIVATE"
  sql_connectivity_update_password = "Password1234!"
  sql_connectivity_update_username = "sqllogin"

  auto_patching {
    day_of_week                            = "Sunday"
    maintenance_window_duration_in_minutes = 60
    maintenance_window_starting_hour       = 2
  }

  storage_configuration {
    disk_type             = "NEW"
    storage_workload_type = "OLTP"
    temp_db_settings {
      default_file_path = "D:\\tempDB"
      luns              = []
    }
  }

}