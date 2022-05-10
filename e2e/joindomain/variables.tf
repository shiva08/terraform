
variable "virtual_machine_id" {
  default = ""
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
  default     = "CORP\\DomainAdmin"
  description = "The prefix used for all resources used by this NetApp Account"
}


variable "domain_join_password" {
  default     = "Contoso!0000"
  description = "The prefix used for all resources used by this NetApp Account"
}
