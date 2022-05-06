variable "vm_count" {
  default     = 2
  description = "The Azure location where all resources in this example should be created."
}

variable "location" {
  default     = "eastus2euap"
  description = "The Azure location where all resources in this example should be created."
}

/*
variable "prefix" {
  default     = "shiva"
  description = "The prefix used for all resources used by this NetApp Account"
}
*/

variable "rgname" {
  default     = "SQL-HA-RG"
  description = "The prefix used for all resources used by this NetApp Account"
}


variable "vnetname" {
  default     = "SQLHAVNET"
  description = "The prefix used for all resources used by this NetApp Account"
}

variable "subnet" {
  default     = "DC-Subnet"
  description = "The prefix used for all resources used by this NetApp Account"
}

variable "localadmin_username" {
  default = ""
} 

variable "localadmin_password" {
  default = ""
}