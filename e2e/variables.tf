variable "vm_count" {
  default     = 2
  description = "The Azure location where all resources in this example should be created."
}

variable "location" {
  default     = "eastus2euap"
  description = "The Azure location where all resources in this example should be created."
}

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
  default = "LocalAdmin"
}

variable "localadmin_password" {
  default = "Contoso!0000"
}

variable "domain_name" {
  default     = "corp.contoso.com"
  description = "The Azure location where all resources in this example should be created."
}

variable "oupath" {
  default     = ""
  description = "The prefix used for all resources used by this NetApp Account"
}


variable "domain_join_username" {
  default = "DomainAdmin"

  description = "The prefix used for all resources used by this NetApp Account"
}

variable "domain_join_password" {
  default     = "Contoso!0000"
  description = "The prefix used for all resources used by this NetApp Account"
}
